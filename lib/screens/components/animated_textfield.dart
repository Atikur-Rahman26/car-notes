import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  @override
  _MyTextFieldWidgetState createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: _isFocused
              ? 'Title'
              : null, // Show 'Title' as labelText when focused
          hintText: 'Enter text', // Show 'Enter text' as hint
        ),
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onEditingComplete: () {
          setState(() {
            _isFocused = false;
          });
        },
      ),
    );
  }
}
