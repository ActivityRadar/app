import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';

class FilterDiscipline extends StatefulWidget {
  const FilterDiscipline({super.key});

  @override
  State<FilterDiscipline> createState() => _FilterDisciplineState();
}

class _FilterDisciplineState extends State<FilterDiscipline> {
  Set<Sport> filters = <Sport>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Wrap(
          spacing: 5.0,
          children: Sport.values.map((Sport exercise) {
            return FilterChip(
              label: CustomText(text: exercise.name),
              selected: filters.contains(exercise),
              selectedColor: DesignColors.naviColor,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    filters.add(exercise);
                  } else {
                    filters.remove(exercise);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10.0),
        CustomText(
          text: 'Looking for: ${filters}',
        ),
      ],
    );
  }
}
