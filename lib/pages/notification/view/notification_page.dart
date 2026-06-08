import 'package:ae_kits/pages/notification/view_model/notification_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationPageController>();
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Notifications"),
        backgroundColor: AppColor.primary,
      ),
      body: controller.notificationBody(),
    );
  }
}
