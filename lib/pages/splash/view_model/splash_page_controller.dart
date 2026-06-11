import 'package:ae_kits/routes/page_names.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    changePage();
  }

  void changePage() async {
    await Future.delayed(
      Duration(seconds: 1),
      () => printInfo(info: "1 Second finished !"),
    );
    Get.toNamed(PageNames.main);
  }
}
