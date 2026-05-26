import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Synchronizing extends StatelessWidget {
  const Synchronizing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/synchronize.svg",
          width: 150,
          height: 150,
        ),
      ],
    );
  }
}
