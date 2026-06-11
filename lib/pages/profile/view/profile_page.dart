import 'package:ae_kits/pages/profile/view_model/profile_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilePageController>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.do_not_touch, color: AppColor.primary),
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: MyText(
          text: "profile".tr,
          style: MyTextStyles.subtitleBold.copyWith(color: AppColor.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // user data container
            controller.userDataContainer(),
            // profile management options
            controller.profileManagementOptions(context),
            // developer info
            Container(
              width: double.infinity,
              height: 300,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  MyText(
                    text: "app_name".tr,
                    style: MyTextStyles.smallBold.copyWith(
                      color: AppColor.grey.withAlpha(120),
                    ),
                  ),
                  MyText(
                    text: "app_type".tr,
                    style: MyTextStyles.extraSmall.copyWith(
                      color: AppColor.grey.withAlpha(120),
                    ),
                  ),
                  MyText(
                    text: "app_dev".tr,
                    style: MyTextStyles.extraSmall.copyWith(
                      color: AppColor.grey.withAlpha(120),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
