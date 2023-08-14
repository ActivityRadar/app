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
