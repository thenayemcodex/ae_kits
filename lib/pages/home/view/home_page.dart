import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/routes/page_names.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/utils/consts.dart';
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
            expandedHeight: 250,
            pinned: true,
            floating: false,
            snap: false,
            backgroundColor: AppColor.secondary,
            elevation: 2,
            centerTitle: true,
            leading: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: AnimatedScale(
                duration: Duration(seconds: 1),
                scale: 1.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: 5),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [AppColor.primary, AppColor.accent],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "app_name".tr,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
              IconButton(
                onPressed: () {
                  Get.toNamed(PageNames.notification);
                },
                icon: const Icon(Icons.notifications),
              ),
              IconButton(
                onPressed: () => (controller.searchBarSize.value == 0.9)
                    ? controller.searchBarSize.value = 0.0
                    : controller.searchBarSize.value = 0.9,
                icon: const Icon(Icons.search),
              ),
            ],
          ),

          // Games type list view. this show category of the gaming kits
          controller.categoryOfGames(),

          // searchBar
          controller.searchBar(),

          // products grid view
          controller.productListView(),
        ],
      ),
    );
  }
}
