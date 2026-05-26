import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/consts.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            floating: false,
            snap: false,
            backgroundColor: AppColor.secondary,
            elevation: 2,
            centerTitle: true,
            leading: Container(
              margin: EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset("assets/logo.png"),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [AppColor.primary, AppColor.accent],
                  ).createShader(bounds);
                },
                child: Text(
                  "app_name".tr,
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Container(
                color: Colors.transparent,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: Consts.latestCollection.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          Consts.latestCollection[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  var current = Get.locale;
                  print("Lang Code: ${current?.languageCode}");
                },
                icon: const Icon(Icons.translate_outlined),
              ),
            ],
          ),

          // Games type list view. this show category of the gaming kits
          controller.categoryOfGames(),

          // products grid view
          controller.productListView(),
        ],
      ),
    );
  }
}
