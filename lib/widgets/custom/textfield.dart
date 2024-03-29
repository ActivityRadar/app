import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.action,
  });

  final TextEditingController controller;
  final String label;
  final TextInputAction? action;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onChanged: (v) => controller.text = v,
        textInputAction: action,
        decoration: InputDecoration(
          filled: true,
          fillColor: DesignColors.kBackground,
          labelText: label,
        ));
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (v) => controller.text = v,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
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
        filled: true,
        fillColor: DesignColors.kBackground,
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
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
        focusedErrorBorder: AppInputBorders.red,
        errorBorder: AppInputBorders.red,
        enabledBorder: AppInputBorders.blue,
        focusedBorder: AppInputBorders.blue,
        labelText: label,
      ),
      validator: validator,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
        focusedErrorBorder: AppInputBorders.red,
        errorBorder: AppInputBorders.red,
        enabledBorder: AppInputBorders.blue,
        focusedBorder: AppInputBorders.blue,
        labelText: label,
      ),
      validator: validator,
    );
  }
}

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField(
      {super.key,
      required this.controller,
      required this.label,
      this.maxLines});

  final TextEditingController controller;
  final String label;
  final int?
      maxLines; // limits the number of shown lines, not the actual number of lines

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
        labelText: label,
        focusedErrorBorder: AppInputBorders.red,
        errorBorder: AppInputBorders.red,
      ),
    );
  }
}

class UnderLineTextFormField extends StatelessWidget {
  const UnderLineTextFormField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
        labelText: label,
        focusedErrorBorder: AppInputBorders.red,
        errorBorder: AppInputBorders.red,
        enabledBorder: AppInputBorders.blue,
        focusedBorder: AppInputBorders.blue,
      ),
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
        focusedErrorBorder: AppInputBorders.red,
        errorBorder: AppInputBorders.red,
        enabledBorder: AppInputBorders.blue,
        focusedBorder: AppInputBorders.blue,
        labelText: label,
      ),
      validator: validator,
    );
  }
}

class UsernameTextFormField extends StatelessWidget {
  const UsernameTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: DesignColors.kBackground,
        focusedErrorBorder: AppInputBorders.red,
        errorBorder: AppInputBorders.red,
        enabledBorder: AppInputBorders.blue,
        focusedBorder: AppInputBorders.blue,
        labelText: label,
      ),
      validator: validator,
    );
  }
}
