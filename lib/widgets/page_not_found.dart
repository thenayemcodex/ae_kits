import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/page_not_found.svg",
          width: 150,
          height: 150,
        ),
      ],
    );
  }
}
