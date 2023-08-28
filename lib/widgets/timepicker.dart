import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key, this.notifier, this.title});

  final ValueNotifier<DateTime>? notifier;
  final String? title;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  final DateTime today = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: today,
      lastDate: today.add(const Duration(days: 14)),
    );

    if (picked != null) {
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

      _selectTime();
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.title != null)
          TitleText(
              text: widget.title!, width: MediaQuery.of(context).size.width),
        TextButton(onPressed: _selectDate, child: Text(formattedDate)),
        TextButton(onPressed: _selectTime, child: Text(formattedTime)),
      ],
    );
  }
}
