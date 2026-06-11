import 'package:ae_kits/pages/order/view_model/order_page_controller.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<OrderPageController>()
        ? Get.find<OrderPageController>()
        : Get.put(() => OrderPageController());
    return Scaffold(
      appBar: AppBar(title: MyText(text: "My Orders"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: MyText(text: "Available Orders . . . "),
          ),
        ],
      ),
    );
  }
}
