import 'package:app/widgets/custom/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/constants/design.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final DateTime today = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: today,
          lastDate: today.add(const Duration(days: 14)),
        ) ??
        selectedDate;
    _selectTime();
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        ) ??
        selectedTime;
    if (picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd.MM.yyyy').format(selectedDate);
    String formattedTime =
        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomListTile(
            icon: Icon(AppIcons.calendarToday),
            titleText: "Datum: $formattedDate",
            onPressed: _selectDate),
        CustomListTile(
            icon: Icon(AppIcons.accessTime),
            titleText: "Uhrzeit: $formattedTime",
            onPressed: _selectTime),
      ],
    );
  }
}
