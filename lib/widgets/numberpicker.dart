import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';

class NumberPicker extends StatefulWidget {
  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int _currentNumber = 1;
  final int _maxNumber = 100;
  final int _minNumber = 1;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '$_currentNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (_currentNumber > _minNumber) {
                _currentNumber--;
                _controller.text = '$_currentNumber';
              }
            });
          },
          icon: Icon(IconConstants.remove),
        ),
        Container(
          width: 50,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              int? number = int.tryParse(value);
              if (number != null &&
                  number >= _minNumber &&
                  number <= _maxNumber) {
                _currentNumber = number;
              } else {
                _controller.text = '$_currentNumber';
              }
            },
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (_currentNumber < _maxNumber) {
                _currentNumber++;
                _controller.text = '$_currentNumber';
              }
            });
          },
          icon: Icon(IconConstants.add),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
