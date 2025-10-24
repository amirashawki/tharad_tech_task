import 'package:evolvify/core/utils/app_style.dart';

import 'package:flutter/material.dart';

class CustomEvolvifyText extends StatelessWidget {
  const CustomEvolvifyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Evolvify', style: AppStyle.styleBold52(context));
  }
}
