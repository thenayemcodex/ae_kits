import 'package:ae_kits/pages/details/model/details_model.dart'
    show DetailsModel;
import 'package:ae_kits/pages/details/view_model/details_page_controller.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/utils.dart' show Utils;
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel product;
  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsPageController>();
    // Check if an offer exists to show a discount badge or strikethrough price
    final bool hasOffer = product.offerValue < product.unitValue;
    controller.currentImage.value = product.productImages.first;
    controller.detailsModel.value = controller.detailsModel.value.copyWith(
      productCode: product.productCode,
    );
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColor.failed,
        foregroundColor: AppColor.white,
        child: Icon(Icons.support_agent),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          constraints: BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Obx(
                      () => Image.network(
                        controller.currentImage.value,
                        height: 400,
                        width: MediaQuery.sizeOf(context).width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        onPressed: () {
                          controller.detailsModel.value = DetailsModel(
                            id: "",
                            productImage: "",
                            productCode: "",
                            productColor: "",
                            productSize: "",
                            quantity: 1,
                          );
                          Get.back();
                        },
                        tooltip: "Go Back",
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.white.withAlpha(150),
                        ),
                        icon: Icon(Icons.arrow_back, color: AppColor.primary),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (product.stock == "Sale")
                              ? AppColor.success
                              : AppColor.failed,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.stock,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.grey.withAlpha(15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: product.productImages
                              .map(
                                (image) => Padding(
                                  padding: const EdgeInsets.only(
                                    right: 5,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      onTap: () {
                                        controller.currentImage.value = image;
                                        controller.detailsModel.value =
                                            controller.detailsModel.value
                                                .copyWith(productImage: image);
                                      },
                                      child: Image.network(
                                        image,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Pricing row
                      Row(
                        children: [
                          Text(
                            '\$${product.offerValue.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.success,
                            ),
                          ),
                          if (hasOffer) ...[
                            const SizedBox(width: 6),
                            Text(
                              '\$${product.unitValue.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.failed,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("Saved Clicked !");
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppColor.failed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: controller.colorSelection(
                          colors: product.productColors,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: controller.sizeSelection(sizes: product.sizes),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    text: product.productDescription * 10,
                    style: MyTextStyles.extraSmall,
                  ),
                ),

                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    text: "Reviews",
                    style: MyTextStyles.extraSmall,
                  ),
                ),

                Container(
                  constraints: BoxConstraints(maxHeight: 400, minHeight: 100),
                  child: controller.reviewListView(reviews: product.reviews),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 30,
        decoration: BoxDecoration(
          color: AppColor.primary,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(10),
          //   topRight: Radius.circular(10),
          // ),
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.detailsModel.value.productCode.isNotEmpty) {
                    if (controller.detailsModel.value.productImage.isNotEmpty) {
                      if (controller
                          .detailsModel
                          .value
                          .productColor
                          .isNotEmpty) {
                        if (controller
                            .detailsModel
                            .value
                            .productSize
                            .isNotEmpty) {
                          print(
                            controller.detailsModel.value.toMap().toString(),
                          );
                          controller.showConfirmationDialog(context, product);
                        } else {
                          Utils.showWarningToast(
                            context,
                            "Product size not selected !",
                          );
                        }
                      } else {
                        Utils.showWarningToast(
                          context,
                          "Product color not selected !",
                        );
                      }
                    } else {
                      Utils.showWarningToast(
                        context,
                        "Product image not selected !",
                      );
                    }
                  } else {
                    Utils.showWarningToast(context, "Product code not found !");
                  }
                },

                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColor.primary),
                  elevation: WidgetStateProperty.all(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_checkout, color: AppColor.white),
                    SizedBox(width: 15),
                    MyText(
                      text: "Add To Check-Out",
                      style: MyTextStyles.subtitleBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 163,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(color: AppColor.secondary),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (controller.detailsModel.value.quantity <= 1) {
                        Utils.showFailedToast(context, "minimum_quantity".tr);
                      } else {
                        controller.detailsModel.value = controller
                            .detailsModel
                            .value
                            .copyWith(
                              quantity:
                                  controller.detailsModel.value.quantity - 1,
                            );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: BorderSide(color: AppColor.primary, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: Icon(Icons.remove),
                  ),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                    child: Obx(
                      () => MyText(
                        text: controller.detailsModel.value.quantity.toString(),
                        style: MyTextStyles.titleBold,
                      ),
                    ),
                  ),

                  OutlinedButton(
                    onPressed: () {
                      controller.detailsModel.value = controller
                          .detailsModel
                          .value
                          .copyWith(
                            quantity:
                                controller.detailsModel.value.quantity + 1,
                          );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: BorderSide(color: AppColor.primary, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
