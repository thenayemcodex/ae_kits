import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainPageController>();
    return Scaffold(
      body: Obx(() => controller.bodyWidget()),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBarPro(
          barHeight: 100,
          cornerRadius: 20,
          activeColor: AppColor.primary,
          inactiveColor: AppColor.grey.withValues(alpha: .4),
          inactiveTextStyle: TextStyle(
            color: AppColor.grey.withValues(alpha: .4),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          activeTextStyle: TextStyle(
            color: AppColor.primary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          items: [
            CurvedNavigationItemPro(
              inactiveIcon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: "home".tr,
            ),
            CurvedNavigationItemPro(
              inactiveIcon: Icons.favorite_border_rounded,
              activeIcon: Icons.favorite_rounded,
              label: "saved".tr,
              badgeText: '•',
            ),
            CurvedNavigationItemPro(
              inactiveIcon: Icons.person_2_outlined,
              activeIcon: Icons.person_2_rounded,
              label: "profile".tr,
            ),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: ((index) {
            controller.currentIndex.value = index;
          }),
        ),
      ),
    );
  }
}
