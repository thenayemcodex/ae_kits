import 'dart:developer';
import 'package:ae_kits/pages/profile/model/profile_model.dart';
import 'package:ae_kits/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseServices extends GetxService {
  static final auth = FirebaseAuth.instance;
  static final CollectionReference usersRef = FirebaseFirestore.instance
      .collection("users");
  static final CollectionReference attendancesRef = FirebaseFirestore.instance
      .collection("attendances");
  static final CollectionReference employeeRef = FirebaseFirestore.instance
      .collection("employees");
  static final CollectionReference locationsRef = FirebaseFirestore.instance
      .collection("locations");
  static final CollectionReference designationsRef = FirebaseFirestore.instance
      .collection("designations");
  static final CollectionReference performancesRef = FirebaseFirestore.instance
      .collection("performances");

  // authentication process
  static Future<String?> login(
    BuildContext context, {
    required String mail,
    required String pass,
  }) async {
    try {
      if (mail.isEmpty || pass.isEmpty) {
        Utils.showWarningToast(
          context,
          "email_address_or_password_cannot_be_empty".tr,
        );
        return null;
      }
      if (pass.length <= 7) {
        Utils.showWarningToast(
          context,
          "password_must_be_at_least_characters_long".tr,
        );
        return null;
      }

      // Sign in the user
      final user = await auth.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
      Utils.showSuccessToast(context, "authentication_successful".tr);
      return user.user?.uid;
    } catch (e) {
      // Handle unexpected errors
      log("Unexpected error occurred: $e");
      Utils.showFailedToast(
        context,
        "an_unexpected_error_occurred_please_try_again".tr,
      );
      return null;
    }
  }

  static Future<bool> register(
    BuildContext context, {
    required String username,
    required String mail,
    required String pass,
  }) async {
    try {
      if (mail.isNotEmpty &&
          username.isNotEmpty &&
          username.length > 5 &&
          pass.isNotEmpty &&
          pass.length > 7) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: mail, password: pass);

        if (userCredential.user?.email != null) {
          ProfileModel profileModel = ProfileModel(
            uid: userCredential.user!.uid,
            username: username,
            gmail: mail,
            mobile: "",
            address: "",
            lang: "en",
            status: false,
            isBlock: false,
          );

          await usersRef
              .doc(userCredential.user!.uid)
              .set(profileModel.toMap());
          await verifyEmail(context);
          Utils.showSuccessToast(
            context,
            "registration_successfully_kindly_verify_your_account_with_the_email_we_have_sent_to_you"
                .tr,
          );
          return true;
        } else {
          Utils.showWarningToast(context, "already_exist".tr);
          return false;
        }
      } else {
        Utils.showWarningToast(
          context,
          "email_address_or_password_is_not_valid".tr,
        );
        return false;
      }
    } catch (e) {
      log("Error occurred while login $e");
      Utils.showFailedToast(context, "registration_failed".tr);
      return false;
    }
  }

  static Future<bool> resetPassword(
    BuildContext context, {
    required String mail,
  }) async {
    try {
      if (mail.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: mail);
        Utils.showSuccessToast(
          context,
          "password_reset_mail_sent_successfully".tr,
        );
        return true;
      } else {
        Utils.showFailedToast(context, "email_address_can_not_be_empty".tr);
        return false;
      }
    } catch (e) {
      Utils.showFailedToast(context, "failed_to_send_password_reset_mail".tr);
      return false;
    }
  }

  static Future<bool> verifyEmail(BuildContext context) async {
    try {
      await auth.currentUser!.sendEmailVerification();
      Utils.showSuccessToast(
        context,
        "verification_mail_has_been_sent_to_your_email_address".tr,
      );
      return true;
    } catch (e) {
      Utils.showFailedToast(context, "failed_to_send_verification_mail".tr);
      return false;
    }
  }

  static bool checkAccountVerificationState(BuildContext context) {
    try {
      var user = auth.currentUser;
      return user!.emailVerified;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signOut(BuildContext context) async {
    try {
      Utils.showLoading(context);
      auth.signOut();
      Utils.showSuccessToast(context, "successfully_sign_out".tr);
      return true;
    } catch (e) {
      Utils.showFailedToast(context, "failed_to_send_verification_mail".tr);
      return false;
    } finally {
      Get.back();
    }
  }


  // static Future<bool> deleteEmployee(
  //   BuildContext context, {
  //   required Employee model,
  // }) async {
  //   try {
  //     String id = model.id;
  //     await employeeRef.document(id).delete();
  //     Utils.showSuccessToast(context, "Deletion successfully");
  //     return true;
  //   } catch (e) {
  //     Utils.showFailedToast(context, "Deletion failed");
  //     return false;
  //   }
  // }

  // accounts
  // static Future<UserDataModel?> getUserData(BuildContext context) async {
  //   try {
  //     if (auth.isSignedIn) {
  //       var response = await usersRef.document(auth.userId).get();
  //       if (response.map.isNotEmpty) {
  //         var map = response.map;
  //         map['id'] = response.id;
  //         return UserDataModel.fromMap(map);
  //       } else {
  //         Utils.showWarningToast(
  //           context,
  //           "User Not Found With This Credentials !",
  //         );
  //         return null;
  //       }
  //     } else {
  //       Utils.showWarningToast(context, "You are not logged in.");
  //       return null;
  //     }
  //   } catch (e) {
  //     log("Error occurred while getting user data $e");
  //     return null;
  //   }
  // }

  // static Future<bool> updateUserData(
  //   BuildContext context, {
  //   required UserDataModel model,
  // }) async {
  //   try {
  //     String id = model.id;
  //     var map = model.toMap();
  //     map.remove("id");
  //     await usersRef.document(id).update(map);
  //     return true;
  //   } catch (e) {
  //     log("Error occurred while getting user data $e");
  //     return false;
  //   }
  // }
}
