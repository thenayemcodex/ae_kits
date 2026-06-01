import 'package:ae_kits/pages/checkout/view_model/checkout_page_controller.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckOutPageController>();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

            child: MyText(
              text: "Your product list . . .",
              style: MyTextStyles.small.copyWith(color: AppColor.grey),
            ),
          ),
          // product list
          Expanded(child: controller.productListView()),
          // total payable information
          controller.costInvoice(),
        ],
      ),
    );
  }
}
