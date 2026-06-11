import 'package:ae_kits/pages/checkout/view/checkout_page.dart';
import 'package:ae_kits/pages/home/view/home_page.dart';
import 'package:ae_kits/pages/profile/view/profile_page.dart';
import 'package:ae_kits/pages/profile/view_model/profile_page_controller.dart';
import 'package:ae_kits/pages/saved/view/saved_page.dart';
import 'package:ae_kits/services/firebase_services.dart';
import 'package:ae_kits/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  RxInt currentIndex = 0.obs;

  Future<void> checkUserCredentials(BuildContext context) async {
    var logdata = await LocalStorage.read(context, key: "log");
    if (logdata != null) {
      var uid = await FirebaseServices.silentLogin(
        context,
        mail: logdata.split(",")[0],
        pass: logdata.split(",")[1],
      );
      if (uid != null) {
        // accessing profile page controller
        final ProfilePageController profilePageController =
            Get.isRegistered<ProfilePageController>()
            ? Get.find<ProfilePageController>()
            : Get.put(ProfilePageController(), permanent: true);
        var result = await FirebaseServices.getUserProfile();
        if (result != null) {
          profilePageController.profileData.value = result;
        } else {
          printError(info: "Failed get user data. Continueing as gaust user !");
        }
      } else {
        printError(info: "User is not logged in. Continueing as gaust user !");
      }
    } else {
      printError(
        info: "Previous log data not found. Continueing as gaust user !",
      );
    }
  }

  Widget bodyWidget() {
    if (currentIndex.value == 0) {
      return const HomePage();
    } else if (currentIndex.value == 1) {
      return const SavedPage();
    } else if (currentIndex.value == 2) {
      return const CheckoutPage();
    } else if (currentIndex.value == 3) {
      return const ProfilePage();
    } else {
      currentIndex.value == 0;
      return const HomePage();
    }
  }
}
