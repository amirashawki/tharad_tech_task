import 'package:flutter/material.dart';

class TextFieldCode extends StatelessWidget {
  const TextFieldCode({super.key, required this.controllers, this.onChanged});

  final TextEditingController controllers;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49,
      height: 49,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD9D9D9)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controllers,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,

        maxLength: 1,

        decoration: InputDecoration(border: InputBorder.none, counterText: ''),
      ),
    );
  }
}
