import 'package:ae_kits/routes/page_names.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 2), () => Get.toNamed(PageNames.main));
  }
}
