import 'package:ae_kits/pages/checkout/view/checkout_page.dart';
import 'package:ae_kits/pages/home/view/home_page.dart';
import 'package:ae_kits/pages/profile/view/profile_page.dart';
import 'package:ae_kits/pages/saved/view/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  RxInt currentIndex = 0.obs;

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
