import 'package:ae_kits/pages/chat/view_model/chat_page_controller.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ChatPageController>()
        ? Get.find<ChatPageController>()
        : Get.put(() => ChatPageController());
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Customer Support"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: MyText(text: "Your chats here . . . "),
          ),
        ],
      ),
    );
  }
}
