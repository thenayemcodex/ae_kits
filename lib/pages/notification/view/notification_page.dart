import 'package:ae_kits/pages/notification/view_model/notification_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationPageController>();
    return Scaffold(body: controller.notificationBody());
  }
}
