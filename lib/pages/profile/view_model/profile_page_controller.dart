import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/pages/profile/model/profile_model.dart';
import 'package:ae_kits/routes/page_names.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_input.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  final mainPageController = Get.find<MainPageController>();

  Rx<ProfileModel> profileData = ProfileModel(
    uid: "",
    username: "",
    gmail: "",
    mobile: "",
    address: "",
    lang: "en",
    status: false,
    isBlock: false,
  ).obs;

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
                Obx(
                  () => MyText(
                    text: profileData.value.username.toUpperCase(),
                    style: MyTextStyles.subtitleBold,
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => MyText(
                    text: profileData.value.gmail.toLowerCase(),
                    style: MyTextStyles.body.copyWith(color: AppColor.grey),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_right),
        ],
      ),
    );
  }

  Widget profileManagementOptions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 582,
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
            onTap: () => Get.toNamed(PageNames.order),
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
            onTap: () {
              updateShippingAddress(context);
            },
            child: Container(
              // height: 50,
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
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(text: "Shipping Address"),
                          if (profileData.value.address != "") ...[
                            MyText(
                              text: profileData.value.address,
                              overflow: TextOverflow.fade,
                              style: MyTextStyles.extraSmall.copyWith(
                                color: AppColor.grey.withAlpha(80),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              // height: 50,
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
                    child: Icon(Icons.translate_rounded),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: MyText(text: "Language")),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () => Get.toNamed(PageNames.chat),
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

  void updateShippingAddress(BuildContext context) {
    TextEditingController village = TextEditingController();
    TextEditingController upozilla = TextEditingController();
    TextEditingController district = TextEditingController();
    TextEditingController division = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController whatsapp = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: MyText(text: "Update Shipping Address "),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: MyInput(
                  controller: village,
                  onChange: (value) {},
                  maxLine: 1,
                  height: 45,
                  label: "village",
                  labelStyle: MyTextStyles.body,
                  borderRadius: BorderRadius.circular(5),
                  borderColer: Colors.transparent,
                  fillColor: AppColor.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: MyInput(
                  controller: upozilla,
                  onChange: (value) {},
                  maxLine: 1,
                  height: 45,
                  label: "upozilla",
                  labelStyle: MyTextStyles.body,
                  borderRadius: BorderRadius.circular(5),
                  borderColer: Colors.transparent,
                  fillColor: AppColor.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: MyInput(
                  controller: district,
                  onChange: (value) {},
                  maxLine: 1,
                  height: 45,
                  label: "district",
                  labelStyle: MyTextStyles.body,
                  borderRadius: BorderRadius.circular(5),
                  borderColer: Colors.transparent,
                  fillColor: AppColor.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: MyInput(
                  controller: division,
                  onChange: (value) {},
                  maxLine: 1,
                  height: 45,
                  label: "division",
                  labelStyle: MyTextStyles.body,
                  borderRadius: BorderRadius.circular(5),
                  borderColer: Colors.transparent,
                  fillColor: AppColor.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: MyInput(
                  controller: mobile,
                  onChange: (value) {},
                  maxLine: 1,
                  height: 45,
                  label: "mobile",
                  labelStyle: MyTextStyles.body,
                  borderRadius: BorderRadius.circular(5),
                  borderColer: Colors.transparent,
                  fillColor: AppColor.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: MyInput(
                  controller: whatsapp,
                  onChange: (value) {},
                  maxLine: 1,
                  height: 45,
                  label: "whatsapp",
                  labelStyle: MyTextStyles.body,
                  borderRadius: BorderRadius.circular(5),
                  borderColer: Colors.transparent,
                  fillColor: AppColor.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    profileData.value = profileData.value.copyWith(
                      address:
                          "${village.text.trim()},${upozilla.text.trim()},${district.text.trim()},${division.text.trim()}, Mobile: ${mobile.text.trim()}, WhatsApp: ${whatsapp.text.trim()}",
                    );
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: AppColor.white),
                      SizedBox(width: 10),
                      MyText(text: "confirm".tr),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
