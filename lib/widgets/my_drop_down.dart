
import 'package:ae_kits/theme/app_color.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  final double? width;
  final double? height;
  final double? scale;
  final double? menuHeight;
  final String hint;
  final Color? background;
  final TextStyle? textStyle;
  final bool? isEnable;
  final List<dynamic> entryList;
  final Function(String value) onSelect;
  final Function? onLeadingClick;
  const MyDropDown(
      {super.key,
      required this.entryList,
      this.width,
      this.height,
      this.menuHeight,
      required this.hint,
      this.background,
      this.textStyle,
      this.isEnable,
      this.scale,
      required this.onSelect,
      this.onLeadingClick});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: SizedBox(
        height: widget.height ?? 40,
        width: widget.width,
        child: DropdownMenu(
          menuHeight: widget.menuHeight ?? 200,
          initialSelection: "Selected Value",
          selectedTrailingIcon: Icon(
            Icons.expand,
            color: AppColor.primary,
          ),
          enabled: widget.isEnable ?? true,
          trailingIcon: IconButton(
              onPressed: () {
                if (widget.onLeadingClick != null) {
                  widget.onLeadingClick!();
                }
              },
              icon: Icon(Icons.arrow_drop_down_sharp)),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
            elevation: WidgetStateProperty.all(0),
            side: WidgetStateProperty.all(
              BorderSide(width: 1, color: AppColor.grey.withValues(alpha: .5)),
            ),
          ),
          width: widget.width,
          hintText: widget.hint,
          textStyle: widget.textStyle,
          onSelected: (value) {
            setState(() {
              widget.onSelect(value);
            });
          },
          enableSearch: true,
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.red,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          dropdownMenuEntries: widget.entryList
              .map((item) => DropdownMenuEntry(
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColor.secondary)),
                    value: item,
                    label: item,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
