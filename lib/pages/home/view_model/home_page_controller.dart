import 'dart:async';

import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/pages/home/view/product_card.dart';
import 'package:ae_kits/services/local_storage.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/consts.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  PageController pageController = PageController();
  RxInt currentView = 0.obs;
  List<String> latestCollection = Consts.latestCollection;
  Timer? _timer;

  // game category widget
  List<String> gameCategories = Consts.gameCategories;
  RxString currentCategory = "All".obs;

  // product grid view
  RxList<ProductModel> updatedProductModel = <ProductModel>[].obs;
  List<ProductModel> completeProductModel = Consts.dummyProducts;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    pageViewChange();

    // get the product data from server
    updatedProductModel.clear();
    updatedProductModel.addAll(completeProductModel);
  }

  // this function used to move latest collection page view
  void pageViewChange() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentView.value == latestCollection.length - 1) {
        currentView.value = 0;
      } else {
        currentView.value++;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentView.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Games type list view. this show category of the gaming kits
  Widget categoryOfGames() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Obx(
                () => MyText(
                  text: "Category: ${currentCategory.value}",
                  style: MyTextStyles.small,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: gameCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          print(gameCategories[index]);
                          currentCategory.value = gameCategories[index];
                          searchByCategory(gameCategories[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              currentCategory.value == gameCategories[index]
                              ? AppColor.primary
                              : AppColor.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: MyText(
                          text: gameCategories[index],
                          style: MyTextStyles.small.copyWith(
                            color:
                                currentCategory.value == gameCategories[index]
                                ? AppColor.secondary
                                : AppColor.primary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // product category search
  void searchByCategory(String category) {
    if (category == "All") {
      updatedProductModel.clear();
      updatedProductModel.addAll(completeProductModel);
    } else {
      updatedProductModel.clear();
      updatedProductModel.addAll(
        completeProductModel
            .where((item) => item.category.contains(category))
            .toList(),
      );
    }
  }

  // Product List View
  Widget productListView() {
    return Obx(() {
      return SliverPadding(
        padding: const EdgeInsets.all(12.0),
        sliver: SliverGrid(
          // 1. This delegate handles the "builder" lazy-loading performance
          delegate: SliverChildBuilderDelegate((context, index) {
            final product = updatedProductModel[index];
            return ProductGridCard(product: product);
          }, childCount: updatedProductModel.length),
          // 2. This layout delegate handles your column configurations
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.72,
          ),
        ),
      );
    });
  }
}
