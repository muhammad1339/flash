import 'package:flutter/material.dart';

class RoundedField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final bool isPassword;

  RoundedField({this.label, @required this.onChanged, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onChanged: onChanged,
        obscureText: isPassword,
      ),
    );
  }
}
