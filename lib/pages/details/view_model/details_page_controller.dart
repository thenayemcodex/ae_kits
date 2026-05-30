import 'package:ae_kits/pages/details/model/details_model.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPageController extends GetxController {
  RxString currentImage = "".obs;

  // customer choise info
  Rx<DetailsModel> detailsModel = DetailsModel(
    id: "",
    productImage: "",
    productCode: "",
    productColor: "",
    productSize: "",
    quantity: 1,
  ).obs;

  Widget colorSelection({required List<String> colors}) {
    return Row(
      children: [
        MyText(text: "Colors:", style: MyTextStyles.extraSmall),
        Row(
          children: colors
              .map(
                (color) => InkWell(
                  onTap: () {
                    detailsModel.value = detailsModel.value.copyWith(
                      productColor: color,
                    );
                  },
                  hoverColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  child: Obx(
                    () => Container(
                      height: 15,
                      width: 30,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Utils.colorFromString(color),
                        border: BoxBorder.all(
                          color: (detailsModel.value.productColor == color
                              ? AppColor.primaryText
                              : Colors.transparent),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget sizeSelection({required List<String> sizes}) {
    return Container(
      child: Row(
        children: [
          MyText(text: "Sizes:", style: MyTextStyles.extraSmall),
          Row(
            children: sizes
                .map(
                  (size) => InkWell(
                    onTap: () {
                      detailsModel.value = detailsModel.value.copyWith(
                        productSize: size,
                      );
                    },
                    hoverColor: Colors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    child: Obx(
                      () => Container(
                        height: 15,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: BoxBorder.all(
                            width: 1,
                            color: (detailsModel.value.productSize == size
                                ? AppColor.primaryText
                                : AppColor.white),
                          ),
                        ),
                        child: Center(
                          child: MyText(
                            text: size,
                            style: MyTextStyles.extraSmall.copyWith(
                              color: AppColor.primaryText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget reviewListView({required List<Map<String, dynamic>> reviews}) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Container(
          // height: 70,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: reviews[index]["userId"],
                    style: MyTextStyles.small,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColor.warning, size: 12),
                      MyText(
                        text: reviews[index]["rating"].toString(),
                        style: MyTextStyles.small,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: MyText(
                  text: reviews[index]["comment"].toString() * 10,
                  style: MyTextStyles.extraSmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showConfirmationDialog(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColor.secondary,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Image.network(
                  detailsModel.value.productImage,
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Pricing row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${(product.offerValue * detailsModel.value.quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.success,
                          ),
                        ),
                      ),
                      MyText(
                        text: "Q: ${detailsModel.value.quantity.toString()}",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyText(
                    text: "Size: ${detailsModel.value.productSize}",
                    style: MyTextStyles.small,
                  ),
                ),

                const SizedBox(height: 6),

                // Pricing row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      MyText(text: "Colors:", style: MyTextStyles.small),

                      Container(
                        height: 15,
                        width: 30,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Utils.colorFromString(
                            detailsModel.value.productColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: AppColor.secondary),
                        SizedBox(width: 15),
                        MyText(
                          text: "Confirm",
                          style: MyTextStyles.smallBold.copyWith(
                            color: AppColor.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
