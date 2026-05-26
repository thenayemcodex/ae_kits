
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DismissibleDelete extends StatelessWidget {
  final Color background;
  final Color foreground;
  final Function()? onclick;
  const DismissibleDelete({super.key, required this.background, required this.foreground, this.onclick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        color: background,
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: foreground,
            ),
            MyText(
              text: "This Item Will Be Deleted !",
              style: MyTextStyles.bodyBold.copyWith(color: foreground),
            )
          ],
        ),
      ),
    );
  }
}
