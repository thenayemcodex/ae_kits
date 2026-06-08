import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/devices.svg",
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
