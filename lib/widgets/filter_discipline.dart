import 'package:app/constants/contants.dart';
import 'package:flutter/material.dart';

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
              label: Text(exercise.name),
              selected: filters.contains(exercise),
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
        Text(
          'Looking for: ${filters}',
          style: textTheme.labelLarge,
        ),
      ],
    );
  }
}
