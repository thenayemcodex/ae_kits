import 'package:ae_kits/pages/details/view_model/details_page_controller.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
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
    return Scaffold(
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
                          Get.back();
                        },
                        tooltip: "Go Back",
                        icon: Icon(Icons.arrow_back_ios_new),
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
                                      onTap: () =>
                                          controller.currentImage.value = image,
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
                    text: "${product.productDescription * 10}",
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {},

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
    );
  }
}
