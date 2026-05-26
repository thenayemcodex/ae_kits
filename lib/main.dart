import 'package:ae_kits/routes/all_binding.dart';
import 'package:ae_kits/routes/all_pages.dart';
import 'package:ae_kits/routes/page_names.dart';
import 'package:ae_kits/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'languages/languages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'app_name'.tr,
      locale: const Locale("en", "US"),
      fallbackLocale: const Locale("en", "US"),
      translations: Languages(),
      translationsKeys: Languages().keys,
      getPages: AllPages.pages,
      initialRoute: PageNames.splash,
      initialBinding: AllBinding(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
