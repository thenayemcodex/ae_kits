import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class MyQrCode extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  const MyQrCode({super.key, required this.text, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: PrettyQrView.data(
        data: text,
        decoration: const PrettyQrDecoration(
          quietZone: PrettyQrQuietZone.standart,
        ),
      ),
    );
  }
}
