import 'dart:async';
import 'dart:developer';

import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/services/firebase_services.dart';
import 'package:ae_kits/services/local_storage.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/page_names.dart';

class AuthenticationPageController extends GetxController {
  bool isResetMailSent = false;

  RxBool isConnectedToInternet = true.obs;
  RxMap<String, dynamic> devDetailsMap = <String, dynamic>{}.obs;
  void checkInternetConnection() async {
    Map<String, dynamic>? devDetails = await Utils.isConnected();
    isConnectedToInternet.value = (devDetails != null);
    if (!devDetails?["permission"] && devDetails != null) {
      devDetailsMap.value = devDetails;
    }
  }

  RxBool isLogin = true.obs;
  void setLoginState(bool value) => isLogin.value = value;

  RxBool isLoading = false.obs;
  void setLoadingState(bool value) => isLoading.value = value;

  TextEditingController usernameController = TextEditingController();
  // TextEditingController gmailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  TextEditingController gmailController = TextEditingController(
    text: "nayeme19@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "nayeme19",
  );

  Future<void> login(BuildContext context) async {
    try {
      setLoadingState(true);
      String? userData = await FirebaseServices.login(
        context,
        mail: gmailController.text.trim(),
        pass: passwordController.text.trim(),
      );
      if (userData != null) {
        setLoadingState(false);
        bool isVerified =
            FirebaseServices.checkAccountVerificationState();
        if (isVerified) {
          final mainController = Get.find<MainPageController>();

          await LocalStorage.write(
            context,
            key: "log",
            value:
                "${gmailController.text.trim()},${passwordController.text.trim()}",
          );
          Get.offAllNamed(PageNames.main);
        } else {
          await FirebaseServices.verifyEmail(context);
        }
      } else {
        setLoadingState(false);
        Utils.showFailedToast(context, "Failed to login, Try again !");
      }
    } catch (e) {
      setLoadingState(false);
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      setLoadingState(true);
      final result = await FirebaseServices.register(
        context,
        username: usernameController.text.trim().replaceAll(" ", ""),
        mail: gmailController.text.trim().replaceAll(" ", ""),
        pass: passwordController.text.trim(),
      );
      setLoginState(result);
      setLoadingState(false);
    } catch (e) {
      setLoadingState(false);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (gmailController.text.trim().isNotEmpty && !isResetMailSent) {
      await FirebaseServices.resetPassword(
        context,
        mail: gmailController.text.trim(),
      );
      isResetMailSent = true;
    } else {
      log("Can Not sent mail. You have to wait 60 second to resend.");
    }

    Future.delayed(const Duration(seconds: 60), () {
      isResetMailSent = false;
    });
  }

  Future<void> verifyAccount(BuildContext context) async {
    if (gmailController.text.trim().isNotEmpty) {
      await FirebaseServices.verifyEmail(context);
    }
  }

  void showDeveloperDetails(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: 430,
          height: 230,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              MyText(
                text: "get_in_touch".tr,
                style: MyTextStyles.titleBold.copyWith(
                  color: AppColor.primaryText,
                  letterSpacing: 3,
                  height: 2,
                ),
              ),
              // const SizedBox(height: 5),
              Divider(thickness: 1, color: AppColor.primary),
              // const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/developer.jpg",
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 0),
                    width: 250,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "dev_name".tr,
                          style: MyTextStyles.titleBold.copyWith(
                            color: AppColor.primary,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyText(
                          text: "dev_expert".tr,
                          style: MyTextStyles.body.copyWith(
                            color: AppColor.primaryText,
                            letterSpacing: 1.5,
                            height: 2.2,
                          ),
                        ),
                        MyText(
                          text: "dev_work".tr,
                          style: MyTextStyles.body.copyWith(
                            color: AppColor.primaryText,
                            letterSpacing: 1.5,
                            height: 2.2,
                          ),
                        ),
                        MyText(
                          text: "dev_mobile".tr,
                          isSelectable: true,
                          style: MyTextStyles.small.copyWith(
                            color: AppColor.secondaryText,
                            letterSpacing: 1.5,
                            height: 2,
                          ),
                        ),
                        MyText(
                          text: "dev_whatsapp".tr,
                          isSelectable: true,
                          style: MyTextStyles.small.copyWith(
                            color: AppColor.secondaryText,
                            letterSpacing: 1.5,
                            height: 2,
                          ),
                        ),
                        MyText(
                          text: "dev_mail".tr,
                          isSelectable: true,
                          style: MyTextStyles.small.copyWith(
                            color: AppColor.secondaryText,
                            letterSpacing: 1.5,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() async {
    // passwordController.text = "";
    super.onInit();
  }

  @override
  void onReady() {
    checkInternetConnection();
    super.onReady();
  }
}
