import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPageController extends GetxController {
  RxString currentImage = "".obs;

  Widget colorSelection({required List<String> colors}) {
    return Container(
      child: Row(
        children: [
          MyText(text: "Colors:", style: MyTextStyles.extraSmall),
          Row(
            children: colors
                .map(
                  (color) => InkWell(
                    onTap: () {},
                    hoverColor: Colors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    child: Container(
                      height: 15,
                      width: 30,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Utils.colorFromString(color),
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

  Widget sizeSelection({required List<String> sizes}) {
    return Container(
      child: Row(
        children: [
          MyText(text: "Sizes:", style: MyTextStyles.extraSmall),
          Row(
            children: sizes
                .map(
                  (size) => InkWell(
                    onTap: () {},
                    hoverColor: Colors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    child: Container(
                      height: 15,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: BoxBorder.all(width: 1, color: AppColor.white),
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
                  text: "${reviews[index]["comment"].toString() * 10}",
                  style: MyTextStyles.extraSmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
