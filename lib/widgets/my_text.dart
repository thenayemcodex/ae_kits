import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyText extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final TextStyle? style;
  final bool? isSelectable;
  const MyText({super.key, required this.text, this.overflow, this.style, this.isSelectable});

  @override
  Widget build(BuildContext context) {
    return (isSelectable ?? false) ? SelectableText(text, onTap: (){
      Clipboard.setData(ClipboardData(text: text));
    },style: style,) :Text(text, overflow: overflow,softWrap: true, style: style,);
  }
}
