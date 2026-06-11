
import 'package:ae_kits/pages/authentication/view_model/authentication_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_input.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = (Get.isRegistered<AuthenticationPageController>()) ? Get.find<AuthenticationPageController>() : Get.put(AuthenticationPageController());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => Center(
                child: (controller.isConnectedToInternet.value && controller.devDetailsMap.isEmpty)
                    ? Container(
                        // height: 500,
                        width: 300,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => (controller.isLogin.value)
                                    ? RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "welcome_to".tr,
                                          style: MyTextStyles.bodyBold,
                                          children: [
                                            TextSpan(
                                              text: "  ".tr,
                                              style: MyTextStyles.bodyBold,
                                            ),
                                            TextSpan(
                                              text: "app_name".tr,
                                              style: MyTextStyles.subtitleBold.copyWith(color: AppColor.accent),
                                            )
                                          ],
                                        ),
                                      )
                                    : MyText(
                                        text: "create_account".tr,
                                        style: MyTextStyles.subtitleBold,
                                      ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                "assets/logo.png",
                                height: 50,
                              ),
                              Obx(
                                () => SizedBox(
                                  child: (!controller.isLogin.value)
                                      ? Padding(
                                          padding: EdgeInsets.only(top: (controller.isLogin.value) ? 50 : 20),
                                          child: MyInput(
                                            controller: controller.usernameController,
                                            onChange: (value) {},
                                            placeholder: "username".tr,
                                            height: 45,
                                            fillColor: AppColor.grey.withValues(alpha: .1),
                                            labelStyle: MyTextStyles.smallBold.copyWith(color: AppColor.accent),
                                           
                                            borderWidth: 1,
                                            borderColer: Colors.transparent,
                                            textColor: AppColor.accent,
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: AppColor.accent,
                                              size: 15,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              MyInput(
                                  controller: controller.gmailController,
                                  onChange: (value) {},
                                  placeholder: "email_address".tr,
                                  height: 45,
                                  fillColor: AppColor.grey.withValues(alpha: .1),
                                  labelStyle: MyTextStyles.smallBold.copyWith(color: AppColor.accent),
                                 
                                  borderWidth: 1,
                                  borderColer: Colors.transparent,
                                  textColor: AppColor.accent,
                                  prefixIcon: Icon(
                                    Icons.alternate_email_rounded,
                                    color: AppColor.accent,
                                    size: 15,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              const SizedBox(height: 20),
                              MyInput(
                                controller: controller.passwordController,
                                onChange: (value) {},
                                placeholder: "password".tr,
                                height: 45,
                                fillColor: AppColor.grey.withValues(alpha: .1),
                                labelStyle: MyTextStyles.smallBold.copyWith(color: AppColor.accent),
                                
                                borderWidth: 1,
                                borderColer: Colors.transparent,
                                textColor: AppColor.accent,
                                isObscure: true,
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color: AppColor.accent,
                                  size: 18,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              Obx(
                                () => Padding(
                                    padding: EdgeInsets.only(top: (controller.isLogin.value) ? 20 : 0),
                                    child: (controller.isLogin.value)
                                        ? InkWell(
                                            onTap: () async {
                                              await controller.resetPassword(context);
                                            },
                                            child: MyText(
                                              text: "forgot_password".tr,
                                              style: MyTextStyles.body.copyWith(color: AppColor.failed),
                                            ),
                                          )
                                        : SizedBox.shrink()),
                              ),
                              const SizedBox(height: 40),
                              FilledButton(
                                onPressed: () async {
                                  if (!controller.isLoading.value) {
                                    if (controller.isLogin.value) {
                                      await controller.login(context);
                                    } else {
                                      await controller.register(context);
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColor.accent),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => (controller.isLoading.value)
                                          ? Transform.scale(
                                              scale: .5,
                                              child: CircularProgressIndicator(
                                                color: AppColor.white,
                                              ),
                                            )
                                          : MyText(
                                              text: (controller.isLogin.value) ? "login".tr : "sign_up".tr,
                                              style: MyTextStyles.bodyBold.copyWith(color: AppColor.white),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => controller.setLoginState(!controller.isLogin.value),
                                child: Obx(
                                  () => MyText(
                                    text: (controller.isLogin.value) ? "do_not_have_an_account".tr : "already_have_an_account".tr,
                                    style: MyTextStyles.body,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : (controller.isConnectedToInternet.value && controller.devDetailsMap.isNotEmpty)
                        ? Container(
                            padding: EdgeInsets.all(20),
                            width: 250,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/maintenance.svg",
                                  height: 140,
                                ),
                                const SizedBox(height: 15),
                                MyText(
                                  text: "access_denied".tr,
                                  style: MyTextStyles.smallBold.copyWith(color: AppColor.grey),
                                ),
                                TextButton(
                                  onPressed: () => controller.showDeveloperDetails(context),
                                  child: MyText(
                                    text: "contact_with_developer".tr,
                                    style: MyTextStyles.extraSmall.copyWith(color: AppColor.primary),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "connection_failed".tr),
                                IconButton(
                                  onPressed: () => controller.checkInternetConnection(),
                                  icon: Icon(Icons.refresh),
                                ),
                              ],
                            ),
                          ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              text: "All Copyrights Reserved By The Nayem Codex",
              style: MyTextStyles.small.copyWith(color: AppColor.grey, fontSize: 8),
            ),
          )
        ],
      ),
    );
  }
}
