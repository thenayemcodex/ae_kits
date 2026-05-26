import 'package:ae_kits/pages/details/view_model/details_page_controller.dart';
import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/pages/profile/view_model/profile_page_controller.dart';
import 'package:ae_kits/pages/saved/view_model/saved_page_controller.dart';
import 'package:ae_kits/pages/splash/view_model/splash_page_controller.dart';
import 'package:get/get.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashPageController());
    Get.put(MainPageController(), permanent: true);
    Get.put(HomePageController(), permanent: true);
    Get.put(SavedPageController());
    Get.put(ProfilePageController());
    Get.put(DetailsPageController());
  }
}
