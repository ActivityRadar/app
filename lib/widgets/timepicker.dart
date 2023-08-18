import 'package:app/widgets/custom/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/constants/design.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key, this.notifier});

  final ValueNotifier<DateTime>? notifier;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
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
      if (widget.notifier != null) {
        final d = widget.notifier!.value;
        widget.notifier!.value =
            DateTime(picked.year, picked.month, picked.day, d.hour, d.minute);
      }

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
      if (widget.notifier != null) {
        final d = widget.notifier!.value;
        widget.notifier!.value =
            DateTime(d.year, d.month, d.day, picked.hour, picked.minute);
      }

      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.notifier != null) {
      selectedDate = widget.notifier!.value;
      selectedTime = TimeOfDay.fromDateTime(widget.notifier!.value);
    } else {
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
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
            text: "Datum: $formattedDate",
            onPressed: _selectDate),
        CustomListTile(
            icon: Icon(AppIcons.accessTime),
            text: "Uhrzeit: $formattedTime",
            onPressed: _selectTime),
      ],
    );
  }
}
