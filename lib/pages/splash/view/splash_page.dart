import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: MyText(text: "Welcome to AE-Kits", style: MyTextStyles.subtitleBold.copyWith()),),
    );
  }
}