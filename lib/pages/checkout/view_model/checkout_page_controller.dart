import 'package:ae_kits/pages/details/model/details_model.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPageController extends GetxController {
  // accessing home page controller
  final homePageController = Get.find<HomePageController>();

  List<DetailsModel> detailsModel = <DetailsModel>[];
  RxList<ProductModel> productModel = <ProductModel>[].obs;

  RxDouble totalUnitCostAmount = 0.0.obs;
  RxDouble totalPayableAmount = 0.0.obs;
  RxDouble totalDeliveryFee = 0.0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    productPreparation();
  }

  void productPreparation() {
    List<ProductModel> allProduct = homePageController.completeProductModel;
    List<String> productsID = detailsModel
        .map((item) => item.productCode)
        .toSet()
        .toList();
    for (var product in allProduct) {
      if (productsID.contains(product.productCode)) {
        if (!productModel.contains(product)) {
          productModel.add(product);
        }
      }
    }

    if (detailsModel.length != productModel.length) {
      printInfo(info: "Details Model & Product Model length is not equal");
    }
  }

  void addNewProduct({required DetailsModel model}) {
    var isExist = detailsModel.contains(model);
    if (!isExist) {
      detailsModel.add(model);
      productPreparation();
    }
  }

  Widget productListView() {
    print("Item Length: ${detailsModel.length} x ${productModel.length}");
    // totalUnitCostAmount.value = 0.0;
    // totalDeliveryFee.value = 0.0;
    // totalPayableAmount.value = 0.0;

    return Obx(
      () => ListView.builder(
        itemCount: productModel.length,
        itemBuilder: (context, index) {
          // Check if an offer exists to show a discount badge or strikethrough price
          final bool hasOffer =
              productModel[index].offerValue < productModel[index].unitValue;
          // cost management
          totalPayableAmount.value =
              totalPayableAmount.value + productModel[index].offerValue;
          totalUnitCostAmount.value =
              totalUnitCostAmount.value + productModel[index].unitValue;
          totalDeliveryFee.value =
              totalDeliveryFee.value + productModel[index].deliveryFees;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Image.network(
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                  detailsModel[index].productImage,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: productModel[index].productName,
                        style: MyTextStyles.bodyBold,
                      ),

                      Row(
                        children: [
                          MyText(
                            text:
                                "Price: ${productModel[index].offerValue.toStringAsFixed(2)} ৳",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.success,
                            ),
                          ),
                          if (hasOffer) ...[
                            const SizedBox(width: 6),
                            Text(
                              '${productModel[index].unitValue.toStringAsFixed(2)} ৳',
                              style: MyTextStyles.extraSmall.copyWith(
                                color: AppColor.failed,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),

                      Row(
                        children: [
                          MyText(
                            text: "Quantity:${detailsModel[index].quantity}",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
                          MyText(
                            text: " Size:${detailsModel[index].productSize}",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyText(
                            text: "Color: ",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 30,
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Utils.colorFromString(
                                detailsModel[index].productColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      (productModel[index].deliveryFees == 0.0)
                          ? MyText(
                              text: "Free Shipping",
                              style: MyTextStyles.extraSmall.copyWith(
                                color: AppColor.success,
                              ),
                            )
                          : MyText(
                              text:
                                  "Shipping: ${productModel[index].deliveryFees.toStringAsFixed(2)} ৳",
                              style: MyTextStyles.extraSmall.copyWith(
                                color: AppColor.grey,
                              ),
                            ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.5,
                        horizontal: 8.5,
                      ),
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          color: AppColor.success,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MyText(
                        text:
                            "${productModel[index].offerValue * detailsModel[index].quantity} ৳",
                        style: MyTextStyles.bodyBold.copyWith(
                          color: AppColor.success,
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: AppColor.failed, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.delete, color: AppColor.failed),
                    ),
                  ],
                ),
              ],
            ),

            // ListTile(
            //   tileColor: AppColor.white,

            //   leading: Padding(
            //     padding: const EdgeInsets.only(top: 10, bottom: 0),
            //     child: Image.network(
            //       height: 50,
            //       width: 50,
            //       fit: BoxFit.cover,
            //       detailsModel[index].productImage,
            //     ),
            //   ),
            //   title: MyText(
            //     text: productModel[index].productName,
            //     style: MyTextStyles.bodyBold,
            //   ),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       MyText(
            //         text: "\$${productModel[index].offerValue.toString()}",
            //         style: MyTextStyles.small.copyWith(color: AppColor.success),
            //       ),
            //       Container(
            //         height: 10,
            //         width: 30,
            //         margin: EdgeInsets.symmetric(vertical: 2),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(2),
            //           color: Utils.colorFromString(
            //             detailsModel[index].productColor,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   isThreeLine: true,
            // ),
          );
        },
      ),
    );
  }

  Widget costInvoice() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 250,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

            child: MyText(
              text: "Payment Summary . . .",
              style: MyTextStyles.small.copyWith(color: AppColor.grey),
            ),
          ),
          Divider(thickness: 1, height: 1, color: AppColor.grey.withAlpha(80)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Total product cost",
                  style: MyTextStyles.small.copyWith(color: AppColor.grey),
                ),
                MyText(
                  text: "${totalUnitCostAmount.value.toStringAsFixed(2)} ৳",
                  style: MyTextStyles.small.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Total shipping cost",
                  style: MyTextStyles.small.copyWith(color: AppColor.grey),
                ),
                MyText(
                  text: "${totalDeliveryFee.value.toStringAsFixed(2)} ৳",
                  style: MyTextStyles.small.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),

          Divider(thickness: 1, height: 1, color: AppColor.grey.withAlpha(80)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Total cost",
                  style: MyTextStyles.smallBold.copyWith(color: AppColor.grey),
                ),
                MyText(
                  text:
                      "${(totalUnitCostAmount.value + totalDeliveryFee.value).toStringAsFixed(2)} ৳",
                  style: MyTextStyles.smallBold.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Promotional discount",
                  style: MyTextStyles.small.copyWith(color: AppColor.grey),
                ),
                MyText(
                  text:
                      "-${(totalUnitCostAmount.value - totalPayableAmount.value).toStringAsFixed(2)} ৳",
                  style: MyTextStyles.small.copyWith(color: AppColor.failed),
                ),
              ],
            ),
          ),

          Divider(thickness: 1, height: 1, color: AppColor.grey.withAlpha(80)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Total Payable Amount",
                  style: MyTextStyles.smallBold.copyWith(color: AppColor.grey),
                ),
                MyText(
                  text:
                      "BDT ${(totalPayableAmount.value + totalDeliveryFee.value).toStringAsFixed(2)} ৳",
                  style: MyTextStyles.smallBold.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: MyText(
                text:
                    "Conratulations, you have saved up to ${(100 - ((totalPayableAmount.value / totalUnitCostAmount.value) * 100)).toStringAsFixed(2)}% on this order !",
                style: MyTextStyles.smallBold.copyWith(color: AppColor.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
