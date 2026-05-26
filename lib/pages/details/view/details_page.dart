import 'package:ae_kits/pages/details/view_model/details_page_controller.dart';
import 'package:ae_kits/pages/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsPageController>();
    return Scaffold(
      body: Center(child: Text("Details ${controller.product.id}}")),
    );
  }
}
