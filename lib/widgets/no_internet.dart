import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/no_internet.svg",
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
