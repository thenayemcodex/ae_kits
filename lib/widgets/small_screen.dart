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
            Transform.scale(
              scale: .5,
              child: SvgPicture.asset(
                "assets/devices.svg",
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
