import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
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
      height: 650,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          MyText(
            text: "Navigations...",
            style: MyTextStyles.body.copyWith(
              color: AppColor.grey.withAlpha(80),
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: AppColor.grey.withAlpha(80),
          ),
        ],
      ),
    );
  }
}
