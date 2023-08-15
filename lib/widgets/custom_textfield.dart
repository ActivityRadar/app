import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.streetController,
    required this.label,
  });

  final TextEditingController streetController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: streetController,
        onChanged: (v) => streetController.text = v,
        decoration: InputDecoration(
          labelText: label,
        ));
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    required this.streetController,
    required this.label,
  });

  final TextEditingController streetController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: streetController,
      onChanged: (v) => streetController.text = v,
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: 3,
      minLines: 2,
    );
  }
}

class DescriptionTextFieldwithoutBorder extends StatelessWidget {
  const DescriptionTextFieldwithoutBorder({
    super.key,
    required this.nameController,
    required this.label,
  });

  final TextEditingController nameController;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      onChanged: (v) => nameController.text = v,
      decoration: InputDecoration(
        border: AppInputBorders.border,
        focusedErrorBorder: AppInputBorders.focusedError,
        errorBorder: AppInputBorders.error,
        enabledBorder: AppInputBorders.enabled,
        focusedBorder: AppInputBorders.focused,
        labelText: label,
      ),
      maxLines: 3,
      minLines: 2,
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelText: labelText),
      validator: validator,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelText: labelText),
      validator: validator,
    );
  }
}

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
    super.key,
    required this.desController,
    required this.hinText,
  });

  final TextEditingController desController;
  final String hinText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      controller: desController,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: hinText,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class UnderLineTextFormField extends StatelessWidget {
  const UnderLineTextFormField({
    super.key,
    required this.controller,
    required this.hinText,
  });

  final TextEditingController controller;
  final String hinText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: hinText,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
