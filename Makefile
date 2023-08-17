generate:
	@echo "Generating Dart classes and backend endpoint methods..."
	python ./openapi-to-dart.py
	@echo "Running build_runner to generate json-serialization code..."
	dart run build_runner build --delete-conflicting-outputs
	@echo "Formatting all generated files..."
	dart format ./lib/model/generated/ ./lib/provider/generated/

fix:
	dart fix --apply --code=prefer_const_constructors
	dart fix --apply --code=prefer_const_declarations
	dart fix --apply --code=prefer_const_literals_to_create_immutables
	dart fix --apply --code=prefer_final_fields
	dart fix --apply --code=prefer_typing_uninitialized_variables
	dart fix --apply --code=unnecessary_brace_in_string_interps
	dart fix --apply --code=unused_import

# this one might break code e.g. where there is an argument variable assigned
# to a member with the same name but with a `_` prefix.
# dart fix --apply --code=no_leading_underscores_for_local_identifiers
