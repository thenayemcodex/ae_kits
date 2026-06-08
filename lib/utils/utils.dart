
import 'dart:convert';
import 'dart:developer';

import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Utils {
  static String dateFormat(int milisec, {required String format}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milisec);
    final DateFormat formatter = DateFormat(format);

    return formatter.format(dateTime);
  }

  static void showFailedToast(BuildContext context, String msg) {
    showToast(
      msg,
      context: context,
      textStyle: MyTextStyles.bodyBold.copyWith(color: AppColor.white),
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: AppColor.failed,
    );
  }

  static void showWarningToast(BuildContext context, String msg) {
    showToast(
      msg,
      context: context,
      textStyle: MyTextStyles.bodyBold.copyWith(color: AppColor.white),
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: AppColor.warning,
    );
  }

  static void showInfoToast(BuildContext context, String msg) {
    showToast(
      msg,
      context: context,
      textStyle: MyTextStyles.bodyBold.copyWith(color: AppColor.white),
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: AppColor.accent,
    );
  }

  static void showSuccessToast(BuildContext context, String msg) {
    showToast(
      msg,
      context: context,
      textStyle: MyTextStyles.bodyBold.copyWith(color: AppColor.white),
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: AppColor.success,
    );
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: 120,
            height: 120,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: AppColor.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SvgPicture.asset(
                "assets/synchronize.svg",
              ),
            ),
          ),
        );
      },
    );
  }

  static Color colorFromString(String hexColor) {
    final buffer = StringBuffer();

    if (hexColor.length == 7 || hexColor.length == 6) {
      buffer.write('ff'); // opacity
    }

    buffer.write(hexColor.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Future<Map<String, dynamic>?> isConnected() async {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/thenayemcodex/Noob-Hacker71/refs/heads/main/authentication.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data["aims_smart_attends"] as Map<String, dynamic>;
      } else {
        log('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  // static Future<DateTime?> getDateTime(BuildContext context) async {
  //   var pickedDate = await showDatePicker(
  //     context: context,
  //     firstDate: DateTime(2025),
  //     lastDate: DateTime(2030),
  //     initialEntryMode: DatePickerEntryMode.calendar,
  //     initialDate: DateTime(2025),
  //   );

  //   return pickedDate;
  // }

  // static Future<TimeOfDay?> getTime(BuildContext context) async {
  //   var pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     initialEntryMode: TimePickerEntryMode.input,
  //   );
  //   return pickedTime;
  // }

  static String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '$hours:$minutes';
  }

  static TimeOfDay intToTimeOfDay(int timeAsInt) {
    int hour = timeAsInt ~/ 100;
    int minute = timeAsInt % 100;
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String formatTimeWithPeriod(int timeAsInt) {
    TimeOfDay time = intToTimeOfDay(timeAsInt);
    String period = time.period == DayPeriod.am ? "AM" : "PM";
    int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }

  static String formatTimeOfDay(TimeOfDay time) {
    String period = time.period == DayPeriod.am ? "AM" : "PM";
    int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }

  // static Future<String?> getLocationFromIP() async {
  //   final response = await http.get(Uri.parse('https://ipinfo.io/json'));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     print('Location: ${data['loc']}'); // latitude,longitude
  //     return data['loc'];
  //   } else {
  //     print('Failed to get location.');
  //     return null;
  //   }
  // }
}
