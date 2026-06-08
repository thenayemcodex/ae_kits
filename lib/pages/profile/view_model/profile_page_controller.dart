import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/routes/page_names.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  final mainPageController = Get.find<MainPageController>();

  Widget userDataContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 70,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.primary.withAlpha(60),

            child: Icon(Icons.person, size: 35, color: AppColor.primary),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: "app_name".tr, style: MyTextStyles.subtitleBold),
                SizedBox(height: 10),
                MyText(
                  text: "nayeme19@gmail.com",
                  style: MyTextStyles.body.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_right),
        ],
      ),
    );
  }

  Widget profileManagementOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 520,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Navigations...",
            style: MyTextStyles.body.copyWith(
              color: AppColor.grey.withAlpha(80),
            ),
          ),
          SizedBox(height: 7),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: AppColor.grey.withAlpha(80),
          ),

          InkWell(
            onTap: () => Get.toNamed(PageNames.notification),
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.notifications_active),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "Notifications")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.delivery_dining),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "My Orders")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              mainPageController.currentIndex.value = 2;
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "My Cart")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              mainPageController.currentIndex.value = 1;
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.favorite_border),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "Saved Items")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.location_on),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "Shipping Address")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.support_agent),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "Customer Support")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primary,
                    child: Icon(Icons.delete),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "Delete Account")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.failed,
                    child: Icon(Icons.logout_outlined),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: MyText(
                      text: "Sign Out",
                      style: MyTextStyles.subtitle.copyWith(
                        color: AppColor.failed,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
