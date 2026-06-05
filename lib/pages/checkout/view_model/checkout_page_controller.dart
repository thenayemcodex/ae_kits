import 'package:ae_kits/pages/details/model/details_model.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/pages/home/view_model/home_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/consts.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:ae_kits/widgets/dismissible_delete.dart';
import 'package:ae_kits/widgets/my_input.dart';
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

  RxBool isNoteAdded = false.obs;
  TextEditingController notesController = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productPreparation();
    });
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

  void calculateTotals() {
    totalUnitCostAmount.value = 0;
    totalPayableAmount.value = 0;
    totalDeliveryFee.value = 0;

    for (int i = 0; i < productModel.length; i++) {
      final qty = detailsModel[i].quantity;

      totalUnitCostAmount.value += productModel[i].unitValue * qty;

      totalPayableAmount.value += productModel[i].offerValue * qty;

      totalDeliveryFee.value += productModel[i].deliveryFees;
    }
  }

  void addNewProduct({required DetailsModel model}) {
    var isExist = detailsModel.contains(model);
    if (!isExist) {
      detailsModel.add(model);
      productPreparation();
    }
  }

  void removeItem({required int index}) {
    detailsModel.removeAt(index);

    productModel.removeAt(index);
    calculateTotals();
  }

  Future<bool?> showDeleteDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes', style: TextStyle(color: AppColor.failed)),
            ),
          ],
        );
      },
    );
  }

  Widget productListView() {
    print("Item Length: ${detailsModel.length} x ${productModel.length}");
    calculateTotals();
    return Container(
      constraints: BoxConstraints(
        minHeight: (productModel.length > 2) ? 180 : 100,
        maxHeight: (productModel.length >= 3)
            ? 270
            : (productModel.length == 2)
            ? 180
            : 100,
      ),
      child: Obx(
        () => ListView.builder(
          itemCount: productModel.length,
          itemBuilder: (context, index) {
            // Check if an offer exists to show a discount badge or strikethrough price
            final bool hasOffer =
                productModel[index].offerValue < productModel[index].unitValue;

            return Dismissible(
              key: UniqueKey(),
              background: DismissibleDelete(
                background: AppColor.failed,
                foreground: AppColor.white,
              ),
              direction: DismissDirection.startToEnd,

              confirmDismiss: (direction) async {
                return await showDeleteDialog(context);
              },

              onDismissed: (direction) {
                removeItem(index: index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
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
                                text:
                                    "Quantity:${detailsModel[index].quantity}",
                                style: MyTextStyles.small.copyWith(
                                  color: AppColor.grey,
                                ),
                              ),
                              MyText(
                                text:
                                    " Size:${detailsModel[index].productSize}",
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
                          padding: EdgeInsets.symmetric(vertical: 8.5),
                          decoration: BoxDecoration(
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
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget costInvoice() {
    return Obx(
      () => (productModel.isNotEmpty)
          ? Container(
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),

                    child: MyText(
                      text: "Payment Summary . . .",
                      style: MyTextStyles.small.copyWith(color: AppColor.grey),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: AppColor.grey.withAlpha(80),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "Total product cost",
                          style: MyTextStyles.small.copyWith(
                            color: AppColor.grey,
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text:
                                "${totalUnitCostAmount.value.toStringAsFixed(2)} ৳",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
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
                          style: MyTextStyles.small.copyWith(
                            color: AppColor.grey,
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text:
                                "${totalDeliveryFee.value.toStringAsFixed(2)} ৳",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    thickness: 1,
                    height: 1,
                    color: AppColor.grey.withAlpha(80),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "Total cost",
                          style: MyTextStyles.smallBold.copyWith(
                            color: AppColor.grey,
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text:
                                "${(totalUnitCostAmount.value + totalDeliveryFee.value).toStringAsFixed(2)} ৳",
                            style: MyTextStyles.smallBold.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
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
                          style: MyTextStyles.small.copyWith(
                            color: AppColor.grey,
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text:
                                "-${(totalUnitCostAmount.value - totalPayableAmount.value).toStringAsFixed(2)} ৳",
                            style: MyTextStyles.small.copyWith(
                              color: AppColor.failed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    thickness: 1,
                    height: 1,
                    color: AppColor.grey.withAlpha(80),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "Total Payable Amount",
                          style: MyTextStyles.smallBold.copyWith(
                            color: AppColor.grey,
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text:
                                "BDT ${(totalPayableAmount.value + totalDeliveryFee.value).toStringAsFixed(2)} ৳",
                            style: MyTextStyles.smallBold.copyWith(
                              color: AppColor.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Obx(
                        () => MyText(
                          text:
                              "Conratulations, you have saved up to ${(100 - ((totalPayableAmount.value / totalUnitCostAmount.value) * 100)).toStringAsFixed(2)}% on this order !",
                          style: MyTextStyles.smallBold.copyWith(
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget deliveryAddress() {
    return Obx(
      () => (productModel.isNotEmpty)
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 80,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),

                    child: MyText(
                      text: "Delivery adrress & contacts",
                      style: MyTextStyles.small.copyWith(color: AppColor.grey),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "Baro-Kajuli, Nagarkanda, Faridpur, Dhaka",
                              style: MyTextStyles.smallBold,
                            ),
                            MyText(
                              text:
                                  "Mobile: 01730548568, WhatsApp: 01730548568",
                              style: MyTextStyles.smallBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget paymentOptions(BuildContext context) {
    return Obx(
      () => (productModel.isNotEmpty)
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 80,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),

                    child: MyText(
                      text: "Available payment options",
                      style: MyTextStyles.small.copyWith(color: AppColor.grey),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: MyText(
                                  text: Consts.paymentOption[0]["name"]!,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),

                          decoration: BoxDecoration(
                            color: AppColor.secondary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  Consts.paymentOption[0]["icon"]!,
                                  width: 45,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),

                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                Consts.paymentOption[1]["icon"]!,
                                width: 45,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),

                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                Consts.paymentOption[2]["icon"]!,
                                width: 45,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),

                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            Consts.paymentOption[3]["icon"]!,
                            width: 45,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),

                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            Consts.paymentOption[4]["icon"]!,
                            width: 45,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget additionalNotesInput() {
    return Obx(
      () => (productModel.isNotEmpty)
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 200,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "I want to send an additional note with parcel.",
                        style: MyTextStyles.small.copyWith(
                          color: AppColor.grey,
                        ),
                      ),
                      Obx(
                        () => Checkbox(
                          checkColor: AppColor.primary,
                          fillColor: WidgetStateProperty.all(
                            AppColor.secondary,
                          ),
                          value: isNoteAdded.value,
                          side: BorderSide(
                            color: AppColor.grey.withAlpha(60),
                            width: 1.5,
                          ),
                          onChanged: (value) {
                            isNoteAdded.value = !isNoteAdded.value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => MyInput(
                      controller: notesController,
                      isReadOnly: !isNoteAdded.value,
                      onChange: (value) {
                        if (value.length > 200) {
                          printError(info: "Note can not be more 200 letter.");
                        }
                      },
                      borderRadius: BorderRadius.circular(5),
                      fillColor: AppColor.white,
                      height: 140,
                      maxLine: 5,
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget paymentButton(BuildContext context) {
    return Obx(
      () => (productModel.isNotEmpty)
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: AppColor.white),
                    SizedBox(width: 10),
                    MyText(text: "confirm".tr),
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
