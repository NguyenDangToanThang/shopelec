import 'package:flutter/material.dart';

class AlertDialogNormal extends StatelessWidget {
  const AlertDialogNormal({
    super.key,
    required TextEditingController textFieldController,
    required this.title,
  }) : _textFieldController = textFieldController;

  final TextEditingController _textFieldController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(5)
      ),
      title: Text(title),
      content: TextField(
        controller: _textFieldController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid
              ),
            )
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white38))
          ),
          child: const Text("Đóng",style: TextStyle(color: Colors.white),),
          onPressed: () => Navigator.pop(context),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white38))
          ),
          child: const Text('Lưu', style: TextStyle(color: Colors.white),),
          onPressed: () => Navigator.pop(context, _textFieldController.text),
        ),
      ],
    );
  }
}