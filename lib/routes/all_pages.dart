import 'package:ae_kits/pages/authentication/view/authentication_page.dart';
import 'package:ae_kits/pages/chat/view/chat_page.dart';
import 'package:ae_kits/pages/home/view/home_page.dart';
import 'package:ae_kits/pages/main/view/main_page.dart';
import 'package:ae_kits/pages/notification/view/notification_page.dart';
import 'package:ae_kits/pages/order/view/order_page.dart';
import 'package:ae_kits/pages/splash/view/splash_page.dart';
import 'package:ae_kits/routes/page_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPages {
  static List<GetPage> pages = [
    GetPage(
      name: PageNames.splash,
      page: () => const SplashPage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: PageNames.auth,
      page: () => const AuthenticationPage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: PageNames.home,
      page: () => const HomePage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: PageNames.main,
      page: () => const MainPage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: PageNames.notification,
      page: () => NotificationPage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: PageNames.order,
      page: () => OrderPage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),

    GetPage(
      name: PageNames.chat,
      page: () => ChatPage(),
      transition: Transition.cupertinoDialog,
      curve: Curves.bounceInOut,
      transitionDuration: const Duration(seconds: 1),
    ),
  ];
}
