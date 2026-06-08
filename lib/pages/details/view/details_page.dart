import 'package:ae_kits/pages/details/model/details_model.dart'
    show DetailsModel;
import 'package:ae_kits/pages/details/view/product_card.dart';
import 'package:ae_kits/pages/details/view_model/details_page_controller.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/utils.dart' show Utils;
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  ProductModel product;
  DetailsPage({super.key, required this.product});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsPageController>();
    // Check if an offer exists to show a discount badge or strikethrough price
    final bool hasOffer = widget.product.offerValue < widget.product.unitValue;
    controller.currentImage.value = widget.product.productImages.first;
    controller.productCategory = widget.product.category;
    controller.detailsModel.value = controller.detailsModel.value.copyWith(
      productCode: widget.product.productCode,
    );
    controller.getSimilarProducts();
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
                          color: (widget.product.stock == "Sale")
                              ? AppColor.success
                              : AppColor.failed,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.product.stock,
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
                          children: widget.product.productImages
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
                        widget.product.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.product.productName,
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
                            '${widget.product.offerValue.toStringAsFixed(2)}৳',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.success,
                            ),
                          ),
                          if (hasOffer) ...[
                            const SizedBox(width: 6),
                            Text(
                              '${widget.product.unitValue.toStringAsFixed(2)}৳',
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
                          colors: widget.product.productColors,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: controller.sizeSelection(
                          sizes: widget.product.sizes,
                        ),
                      ),
                      if (widget.product.deliveryFees == 0) ...[
                        Row(
                          children: [
                            Icon(Icons.delivery_dining, size: 12),
                            SizedBox(width: 5),
                            MyText(
                              text: "Free delivery",
                              style: MyTextStyles.extraSmall.copyWith(
                                color: AppColor.success,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    text:
                        "Description: ${widget.product.productDescription * 10}",
                    style: MyTextStyles.extraSmall,
                  ),
                ),

                Divider(),
                // similiar product list view
                SizedBox(
                  height: 250,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.similarProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          widget.product = controller.similarProducts[index];
                          setState(() {});
                        },
                        child: SizedBox(
                          width: 150,
                          child: ProductGridCard(
                            product: controller.similarProducts[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    text: "Reviews",
                    style: MyTextStyles.extraSmall,
                  ),
                ),

                controller.reviewListView(reviews: widget.product.reviews),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 30,
        decoration: BoxDecoration(color: AppColor.primary),
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
                          controller.showConfirmationDialog(
                            context,
                            widget.product,
                          );
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
              width: 123,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(color: AppColor.secondary),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 30,
                    child: OutlinedButton(
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
                  ),

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                    child: Obx(
                      () => MyText(
                        text: controller.detailsModel.value.quantity.toString(),
                        style: MyTextStyles.titleBold,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 30,
                    child: OutlinedButton(
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
