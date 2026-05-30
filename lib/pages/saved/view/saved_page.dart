import 'package:ae_kits/pages/saved/view_model/saved_page_controller.dart';
import 'package:ae_kits/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavedPageController>();
    controller.getSavedItems(context);
    
    return Scaffold(
      body: // products grid view
      controller
          .productListView(),
    );
  }
}
