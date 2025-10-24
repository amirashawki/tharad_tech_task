import 'package:flutter/material.dart';

class CutsomArrowios extends StatelessWidget {
  const CutsomArrowios({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
        color: Color(0xff292D32),
      ),
    );
  }
}
