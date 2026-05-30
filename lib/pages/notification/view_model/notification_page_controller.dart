import 'package:ae_kits/pages/main/view_model/main_page_controller.dart';
import 'package:ae_kits/pages/notification/model/notification_model.dart';
import 'package:ae_kits/routes/page_names.dart';
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:ae_kits/utils/consts.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:ae_kits/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  // main page controller
  final controller = Get.find<MainPageController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    notifications.addAll(Consts.notifications);
  }

  void addNewNotification({required NotificationModel notification}) {
    notifications.add(notification);
  }

  void deleteNotification({required NotificationModel notification}) {
    notifications.remove(notification);
  }

  Widget notificationBody() {
    return Obx(
      () => ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: ListTile(
              onTap: () {
                switch (notifications[index].page) {
                  case "home":
                    controller.currentIndex.value = 0;
                    Get.toNamed(PageNames.main);

                    break;
                  case "saved":
                    controller.currentIndex.value = 1;
                    Get.toNamed(PageNames.main);
                    break;
                  case "checkout":
                    controller.currentIndex.value = 2;
                    Get.toNamed(PageNames.main);
                    break;
                  case "profile":
                    controller.currentIndex.value = 3;
                    Get.toNamed(PageNames.main);
                    break;
                  case "order":
                    Utils.showInfoToast(
                      context,
                      "Order page in under development",
                    );
                    break;
                  default:
                    printError(info: "No redirect page mentioned");
                }
              },
              splashColor: AppColor.primary,
              tileColor: (notifications[index].isRead)
                  ? AppColor.white
                  : AppColor.secondary,
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              leading: CircleAvatar(
                child: MyText(text: notifications[index].page[0].toUpperCase()),
              ),
              title: MyText(
                text: notifications[index].title,
                style: MyTextStyles.smallBold,
              ),
              subtitle: MyText(
                text: notifications[index].body,
                style: MyTextStyles.extraSmall,
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == "delete") {
                    deleteNotification(notification: notifications[index]);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "delete",
                    child: MyText(
                      text: "delete".tr,
                      style: MyTextStyles.body.copyWith(color: AppColor.failed),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
