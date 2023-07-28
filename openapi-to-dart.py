"""
    This script was initially created by GPT4.0 in a request to write a script that converts
    an openapi schema to Dart classes that are json serializable.

    It was then modified to account for special cases (e.g. handling of enums, imports and more)
"""

import re
import yaml

# Read the yaml file
with open("openapi.yaml", "r") as file:
    openapi_schema = yaml.safe_load(file)

# Extract components
components = openapi_schema.get("components", {}).get("schemas", {})


def to_camel_case(snake_str):
    components = snake_str.split("_")
    return components[0] + "".join(x.title() for x in components[1:])


camel_pattern = re.compile(r"(?<!^)(?=[A-Z])")


def to_snake_case(name):
    return camel_pattern.sub("_", name).lower()


def to_dart_type(t):
    match t:
        case "integer":
            return "int"
        case "object":
            return "Object"
        case "string":
            return "String"
        case "number":
            return "double"
        case _:
            return "Object"


def parse_enum(name, component):
    type_ = component.get("type")
    members = component.get("enum")

    values = "\n".join([f"  @JsonValue('{m}') {m}," for m in members])
    template = f"""enum {name} {{\n{values}\n}}"""
    return template


def generate_dart_classes_new(components):
    class_templates = []
    enum_templates = []

    for class_name, component in components.items():
        if component.get("enum"):
            enum_templates.append((class_name, parse_enum(class_name, component)))
            continue

        properties = component.get("properties", {})
        required_properties = component.get("required", [])

        class_properties = []
        class_property_names_and_req = []
        imports = []

        for property_name, property_info in properties.items():
            property_type = property_info.get("type", "Object")
            is_required = property_name in required_properties
            property_name_camel_case = to_camel_case(property_name)

            if property_type == "array":
                item_info = property_info.get("items", {})
                item_type = item_info.get("type", "Object")
                if "$ref" in item_info:
                    item_type = item_info["$ref"].split("/")[-1]
                    property_type = f"List<{item_type}>"
                    imports.append(item_type)
                else:
                    property_type = f"List<{to_dart_type(item_type)}>"
            elif "$ref" in property_info:
                property_type = property_info["$ref"].split("/")[-1]
                imports.append(property_type)
            else:
                property_type = to_dart_type(property_type)

            null_suffix = "" if is_required else "?"
            class_property_names_and_req.append((property_name_camel_case, is_required))

            json_key = ""
            if property_name_camel_case != property_name:
                json_key = f"""  @JsonKey(name: "{property_name}")\n"""

            class_properties.append(
                json_key
                + f"  final {property_type}{null_suffix} {property_name_camel_case};"
            )

        class_template = (
            f"@JsonSerializable(explicitToJson: true)\nclass {class_name} {{\n"
        )
        class_template += "\n".join(class_properties)
        class_template += "\n\n"

        constructor_args = ",\n".join(
            [
                " " * 4 + ("required " if r else "") + f"this.{p}"
                for p, r in class_property_names_and_req
            ]
        )

        class_template += f"  {class_name}({{\n{constructor_args}}});"
        class_template += f"\n\n  factory {class_name}.fromJson(Map<String, dynamic> json) => _${class_name}FromJson(json);\n"
        class_template += (
            f"\n  Map<String, dynamic> toJson() => _${class_name}ToJson(this);\n"
        )
        class_template += "}\n"

        class_templates.append((class_template, class_name, imports))

    return class_templates, enum_templates


class_templates, enum_templates = generate_dart_classes_new(components)

header = f"""/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

"""

export_file = open("lib/model/generated.dart", "w")
export_file.write(
    "/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py\n\n"
)

for t, name, imports in class_templates:
    snake_case = to_snake_case(name)
    with open(f"lib/model/generated/{snake_case}.dart", "w") as f:
        f.write(header)
        f.write("import 'package:json_annotation/json_annotation.dart';\n\n")
        for imp in imports:
            f.write(
                f"import 'package:app/model/generated/{to_snake_case(imp)}.dart';\n"
            )
        f.write(f"part '{snake_case}.g.dart';\n\n")
        f.write(t)

    export_file.write(f"export 'generated/{snake_case}.dart' show {name};\n")

for name, t in enum_templates:
    snake_case = to_snake_case(name)
    with open(f"lib/model/generated/{snake_case}.dart", "w") as f:
        f.write(header)
        f.write("import 'package:json_annotation/json_annotation.dart';\n\n")
        f.write(t)

    export_file.write(f"export 'generated/{snake_case}.dart' show {name};\n")

export_file.close()