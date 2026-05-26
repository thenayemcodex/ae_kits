import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/no_data.svg",
          width: 150,
          height: 150,
        ),
      ],
    );
  }
}
