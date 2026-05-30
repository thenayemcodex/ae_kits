import 'package:ae_kits/pages/details/view/details_page.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/pages/saved/view_model/saved_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGridCard extends StatelessWidget {
  final ProductModel product;

  const ProductGridCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Check if an offer exists to show a discount badge or strikethrough price
    final bool hasOffer = product.offerValue < product.unitValue;

    // access saved page controller
    final savedPageController = Get.find<SavedPageController>();

    return InkWell(
      onTap: () {
        print("Card Clicked !");
        Get.to(() => DetailsPage(product: product));
      },
      borderRadius: BorderRadius.circular(12.0),
      splashColor: AppColor.primary.withValues(alpha: .1),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior:
            Clip.antiAlias, // Ensures images respect the border radius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image Layer
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    product.productImages.isNotEmpty
                        ? product.productImages[0]
                        : 'https://images.unsplash.com/photo-1531403009284-440f080d1e12?w=500', // fallback
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    left: 8,
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
                ],
              ),
            ),

            // 2. Details Layer
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
                                print("Delete Clicked !");
                                savedPageController.deleteItem(
                                  context,
                                  productID: product.id,
                                );
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
