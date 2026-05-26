
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DismissibleUpdate extends StatelessWidget {
  final String? text;
  final Color background;
  final Color foreground;
  final Function()? onclick;
  const DismissibleUpdate({super.key, this.text, required this.background, required this.foreground, this.onclick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        color: background,
        child: Row(
          children: [
            Icon(
              Icons.edit_calendar_rounded,
              color: foreground,
            ),
            MyText(
              text: text ?? "This Item Will Be Updated !",
              style: MyTextStyles.bodyBold.copyWith(color: foreground),
            )
          ],
        ),
      ),
    );
  }
}
