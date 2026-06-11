import 'package:ae_kits/pages/authentication/view_model/authentication_page_controller.dart';
import 'package:ae_kits/pages/chat/view_model/chat_page_controller.dart';
import 'package:ae_kits/pages/checkout/view_model/checkout_page_controller.dart';
import 'package:ae_kits/pages/details/view_model/details_page_controller.dart';
import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/pages/notification/view_model/notification_page_controller.dart';
import 'package:ae_kits/pages/order/view_model/order_page_controller.dart';
import 'package:ae_kits/pages/profile/view_model/profile_page_controller.dart';
import 'package:ae_kits/pages/saved/view_model/saved_page_controller.dart';
import 'package:ae_kits/pages/splash/view_model/splash_page_controller.dart';
import 'package:get/get.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController());
    Get.put(MainPageController(), permanent: true);
    Get.put(NotificationPageController(), permanent: true);
    Get.lazyPut(() => ProfilePageController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => SavedPageController());
    Get.lazyPut(() => AuthenticationPageController());
    Get.lazyPut(() => CheckOutPageController());
    Get.put(DetailsPageController(), permanent: true);
    Get.lazyPut(() => OrderPageController());
    Get.lazyPut(() => ChatPageController());
  }
}
