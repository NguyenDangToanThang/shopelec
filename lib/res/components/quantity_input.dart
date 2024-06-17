import 'package:flutter/material.dart';

class QuantityInput extends StatefulWidget {
  final int maxVal;
  final int initVal;
  final int steps;
  final Function(int) onQtyChanged;

  const QuantityInput({
    super.key,
    required this.maxVal,
    required this.initVal,
    required this.steps,
    required this.onQtyChanged,
  });

  @override
  _QuantityInputState createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
 
  late int _currentVal;

  @override
  void initState() {
    super.initState();
    _currentVal = widget.initVal;
  }

  void _increment() {
    setState(() {
      if (_currentVal + widget.steps <= widget.maxVal) {
        _currentVal += widget.steps;
        widget.onQtyChanged(_currentVal);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_currentVal - widget.steps >= 1) {
        _currentVal -= widget.steps;
        widget.onQtyChanged(_currentVal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: IconButton(
              onPressed: _decrement,
              icon: const Icon(Icons.remove, color: Colors.black),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$_currentVal',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(
            width: 35,
            child: IconButton(
              onPressed: _increment,
              icon: const Icon(Icons.add, color: Colors.black),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
