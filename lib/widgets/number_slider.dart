import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ListeningSlider extends StatelessWidget {
  const ListeningSlider(
      {super.key,
      required this.valueNotifier,
      required this.textFormatter,
      this.leading});

  final ValueNotifier<double> valueNotifier;
  final String Function(double) textFormatter;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return ListTile(
              title: Row(
            children: [
              if (leading != null) leading!,
              Slider(
                value: value,
                max: 25,
                divisions: 25,
                label: value.round().toString(),
                onChanged: (double value_) {
                  valueNotifier.value = value_;
                },
              ),
              CustomText(text: textFormatter(value))
            ],
          ));
        });
  }
}
