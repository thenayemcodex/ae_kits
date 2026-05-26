import 'package:flutter/material.dart';

class AppColor {
  static Color primary = Color.fromARGB(255, 73, 88, 255);
  static Color secondary = Color(0xfff1f1ff);
  static Color accent = Color(0xff6CCFF6);
  static Color grey = Color(0xff595959);
  static Color white = Color(0xfff6f9ff);

  static Color primaryText = Color(0xff100f0f);
  static Color secondaryText = Color(0xff2b2c2f);

  static Color failed = Color(0xfffc4545);

  static Color warning = Color(0xffb7af0b);
  static Color success = Color.fromARGB(255, 59, 199, 43);

  static final Map<String, Color> attendanceColors = {
    "p": Color(0xff60f74f), // Present
    "wfh": Colors.blue, // Work from Home
    "a": Colors.orange, // Absent
    "c": Colors.blueAccent, // Compensatory
    "w": Colors.purple, // Weekly Off
    "ph": Colors.deepPurple, // Public Holiday
    "wp": Colors.lightGreen, // Weekly Present
    "hp": Colors.greenAccent, // Holiday Present
    "hd": Colors.yellow, // Half Day
    "sl": Colors.deepOrange, // Sick Leave
    "al": Colors.amber, // Annual Leave
    "os": Colors.red, // Over Stay
    "r": Colors.grey, // Resigned
    "s": Colors.black87, // Suspended
    "el": Colors.orangeAccent, // Emergency Leave
    "t": Colors.redAccent, // Termination
  };
}
