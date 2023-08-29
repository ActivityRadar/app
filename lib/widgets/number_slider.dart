import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ListeningSlider extends StatelessWidget {
  const ListeningSlider(
      {super.key,
      required this.valueNotifier,
      required this.textFormatter,
      this.leading,
      this.discrete = true,
      required this.min,
      required this.max});

  final ValueNotifier<double> valueNotifier;
  final String Function(double) textFormatter;
  final Widget? leading;
  final bool discrete;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null) leading!,
              Expanded(
                  child: Slider(
                value: value,
                min: discrete ? min.floorToDouble() : min,
                max: discrete ? max.floorToDouble() : max,
                onChanged: (double value_) {
                  valueNotifier.value = value_;
                },
              )),
              CustomText(text: textFormatter(value))
            ],
          ));
        });
  }
}
