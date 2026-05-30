import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/pages/saved/view/product_card.dart';
import 'package:ae_kits/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedPageController extends GetxController {
  // access homepage controller
  final homePageController = Get.find<HomePageController>();

  // saved items
  RxList<ProductModel> products = <ProductModel>[].obs;

  // manage saved item in local storage
  final storageKey = "SAVED_ITEMS";
  List<String> savedItemsID = [];

  // get all saved items from local storage
  void getSavedItems(BuildContext context) async {
    // await LocalStorage.delete(context, key: storageKey);
    var result = await LocalStorage.read(context, key: storageKey);
    if (result != null) {
      savedItemsID.clear();
      var list = result
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((item) => item.trim())
          .where((item) => item.isNotEmpty)
          .toList();
      savedItemsID = list.toSet().toList();
    }
    printInfo(info: "Total Saved Item: ${savedItemsID.toString()}");
    if (savedItemsID.isNotEmpty) {
      products.clear();
      for (var item in homePageController.completeProductModel) {
        printError(
          info:
              "${item.id.trim()} found ${savedItemsID.contains(item.id.trim())}",
        );
        if (savedItemsID.contains(item.id.trim())) {
          products.add(item);
        }
      }
      printInfo(info: "Total Product Count: ${products.length}");
    }
  }

  void addNewItem(BuildContext context, {required String productID}) async {
    if (!savedItemsID.contains(productID)) {
      savedItemsID.add(productID);
      await LocalStorage.write(
        context,
        key: storageKey,
        value: savedItemsID.toString(),
      );
    }
  }

  void deleteItem(BuildContext context, {required String productID}) async {
    await LocalStorage.delete(context, key: storageKey);
    print("Contains:  ${savedItemsID.contains(productID)}");
    if (savedItemsID.contains(productID)) {
      savedItemsID.remove(productID);
      await LocalStorage.write(
        context,
        key: storageKey,
        value: savedItemsID.toString(),
      );
    }
  }

  // Product List View
  Widget productListView() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductGridCard(product: product);
          },
        ),
      );
    });
  }
}
