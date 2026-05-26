// import 'dart:developer';

// import 'package:aims_smart_attends/pages/attends/model/attendance.dart';
// import 'package:aims_smart_attends/pages/authentication/model/user_data_model.dart';
// import 'package:aims_smart_attends/pages/designation/model/designation.dart';
// import 'package:aims_smart_attends/pages/employee/model/employee.dart';
// import 'package:aims_smart_attends/pages/locations/model/location.dart';
// import 'package:aims_smart_attends/pages/performance/model/performance.dart';
// import 'package:aims_smart_attends/styles/app_color.dart';
// import 'package:aims_smart_attends/styles/my_text_styles.dart';
// import 'package:aims_smart_attends/utils/utils.dart';
// import 'package:aims_smart_attends/widgets/my_text.dart';
// import 'package:firedart/auth/user_gateway.dart';
// import 'package:firedart/firedart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FirebaseServices extends GetxService {
//   static final auth = FirebaseAuth.instance;
//   static final CollectionReference usersRef = Firestore.instance.collection("users");
//   static final CollectionReference attendancesRef = Firestore.instance.collection("attendances");
//   static final CollectionReference employeeRef = Firestore.instance.collection("employees");
//   static final CollectionReference locationsRef = Firestore.instance.collection("locations");
//   static final CollectionReference designationsRef = Firestore.instance.collection("designations");
//   static final CollectionReference performancesRef = Firestore.instance.collection("performances");

//   // authentication process
//   static Future<String?> login(BuildContext context, {required String mail, required String pass}) async {
//     try {
//       if (mail.isEmpty || pass.isEmpty) {
//         Utils.showWarningToast(context, "email_address_or_password_cannot_be_empty".tr);
//         return null;
//       }
//       if (pass.length <= 7) {
//         Utils.showWarningToast(context, "password_must_be_at_least_characters_long".tr);
//         return null;
//       }

//       // Sign in the user
//       final user = await auth.signIn(mail, pass);
//       Utils.showSuccessToast(context, "authentication_successful".tr);
//       return user.id;
//     } catch (e) {
//       // Handle unexpected errors
//       log("Unexpected error occurred: $e");
//       Utils.showFailedToast(context, "an_unexpected_error_occurred_please_try_again".tr);
//       return null;
//     }
//   }

//   static Future<bool> register(BuildContext context, {required String username, required String mail, required String pass}) async {
//     try {
//       if (mail.isNotEmpty && username.isNotEmpty && username.length > 5 && pass.isNotEmpty && pass.length > 7) {
//         User user = await auth.signUp(mail, pass);

//         if (auth.isSignedIn && user.email != null) {
//           if (user.email != null) {
//             log("Signed In ${user.id}"); // Use user.uid to get the ID
//             UserDataModel userDataModel = UserDataModel(
//                 id: auth.userId,
//                 eid: "",
//                 username: username,
//                 fullname: "",
//                 email: mail,
//                 mobile: "",
//                 position: "",
//                 zone: "",
//                 location: "",
//                 dutyStart: TimeOfDay.now().hour,
//                 dutyEnd: ((TimeOfDay.now().hour + 8) < 24) ? (TimeOfDay.now().hour + 8) : ((TimeOfDay.now().hour + 8) - 24),
//                 accessPriority: 1,
//                 status: false);
//             await usersRef.document(user.id).set(userDataModel.toMap()); // user.uid
//             await verifyEmail(context);
//             Utils.showSuccessToast(context, "registration_successfully_kindly_verify_your_account_with_the_email_we_have_sent_to_you".tr);
//             return true;
//           } else {
//             Utils.showFailedToast(context, "registration_failed".tr);
//             log("Sign up failed");
//             return false;
//           }
//         } else {
//           Utils.showWarningToast(context, "already_exist".tr);
//           return false;
//         }
//       } else {
//         Utils.showWarningToast(context, "email_address_or_password_is_not_valid".tr);
//         return false;
//       }
//     } catch (e) {
//       log("Error occurred while login $e");
//       Utils.showFailedToast(context, "registration_failed".tr);
//       return false;
//     }
//   }

//   static Future<bool> resetPassword(BuildContext context, {required String mail}) async {
//     try {
//       if (mail.isNotEmpty) {
//         await auth.resetPassword(mail);
//         Utils.showSuccessToast(context, "password_reset_mail_sent_successfully".tr);
//         return true;
//       } else {
//         Utils.showFailedToast(context, "email_address_can_not_be_empty".tr);
//         return false;
//       }
//     } catch (e) {
//       Utils.showFailedToast(context, "failed_to_send_password_reset_mail".tr);
//       return false;
//     }
//   }

//   static Future<bool> verifyEmail(BuildContext context) async {
//     try {
//       await auth.requestEmailVerification(langCode: "us");
//       Utils.showSuccessToast(context, "verification_mail_has_been_sent_to_your_email_address".tr);
//       return true;
//     } catch (e) {
//       Utils.showFailedToast(context, "failed_to_send_verification_mail".tr);
//       return false;
//     }
//   }

//   static Future<bool> checkAccountVerificationState(BuildContext context) async {
//     try {
//       var user = await auth.getUser();
//       return user.emailVerified ?? false;
//     } catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> signOut(BuildContext context) async {
//     try {
//       Utils.showLoading(context);
//       auth.signOut();
//       Utils.showSuccessToast(context, "successfully_sign_out".tr);
//       return true;
//     } catch (e) {
//       Utils.showFailedToast(context, "failed_to_send_verification_mail".tr);
//       return false;
//     } finally {
//       Get.back();
//     }
//   }

//   // employee
//   static Future<bool> addNewEmployee(BuildContext context, {required Employee model, required bool isNew}) async {
//     try {
//       if (isNew) {
//         String eid = model.eid;
//         var check = await employeeRef.where("eid", isEqualTo: eid).get();
//         if (check.isNotEmpty) {
//           Utils.showFailedToast(context, "already_exist".tr);
//           return false;
//         } else {
//           var dataMap = model.toMap();
//           dataMap.remove("id");
//           await employeeRef.add(dataMap);
//           Utils.showSuccessToast(context, "successfully_added".tr);
//           return true;
//         }
//       } else {
//         var dataMap = model.toMap();
//         String id = dataMap["id"];
//         dataMap.remove("id");
//         await employeeRef.document(id).update(dataMap);
//         log("Updated Employee Document ID $id");
//         Utils.showSuccessToast(context, "successfully_updated".tr);
//         return true;
//       }
//     } catch (e) {
//       log("Error occurred while adding new employee $e");
//       return false;
//     }
//   }

//   static Future<bool> importEmployees(BuildContext context, {required Employee model}) async {
//     try {
//       String eid = model.eid;
//       var check = await employeeRef.where("eid", isEqualTo: eid).get();
//       if (check.isNotEmpty) {
//         return false;
//       } else {
//         var dataMap = model.toMap();
//         dataMap.remove("id");
//         await employeeRef.add(dataMap);
//         return true;
//       }
//     } catch (e) {
//       log("Error occurred while adding new employee $e");
//       return false;
//     }
//   }

//   static Future<List<Employee>?> getAllEmployee(BuildContext context, {required String zone}) async {
//     try {
//       print("Zone: $zone");
//       if (zone == "all") {
//         var response = await employeeRef.get();
//         if (response.isNotEmpty) {
//           print("count: ${response.length}");
//           return response.map((item) {
//             var map = item.map;
//             map["id"] = item.id;
//             return Employee.fromMap(map);
//           }).toList();
//         } else {
//           return null;
//         }
//       } else {
//         var response = await employeeRef.where("zone", isEqualTo: zone).get();
//         if (response.isNotEmpty) {
//           print("count: ${response.length}");
//           return response.map((item) {
//             var map = item.map;
//             map["id"] = item.id;
//             return Employee.fromMap(map);
//           }).toList();
//         } else {
//           return null;
//         }
//       }
//     } catch (e) {
//       print("Error occurred while getting all employee $e");
//       return null;
//     }
//   }

//   static Future<bool> deleteEmployee(BuildContext context, {required Employee model}) async {
//     try {
//       String id = model.id;
//       await employeeRef.document(id).delete();
//       Utils.showSuccessToast(context, "Deletion successfully");
//       return true;
//     } catch (e) {
//       Utils.showFailedToast(context, "Deletion failed");
//       return false;
//     }
//   }

//   // accounts
//   static Future<UserDataModel?> getUserData(BuildContext context) async {
//     try {
//       if (auth.isSignedIn) {
//         var response = await usersRef.document(auth.userId).get();
//         if (response.map.isNotEmpty) {
//           var map = response.map;
//           map['id'] = response.id;
//           return UserDataModel.fromMap(map);
//         } else {
//           Utils.showWarningToast(context, "User Not Found With This Credentials !");
//           return null;
//         }
//       } else {
//         Utils.showWarningToast(context, "You are not logged in.");
//         return null;
//       }
//     } catch (e) {
//       log("Error occurred while getting user data $e");
//       return null;
//     }
//   }

//   static Future<bool> updateUserData(BuildContext context, {required UserDataModel model}) async {
//     try {
//       String id = model.id;
//       var map = model.toMap();
//       map.remove("id");
//       await usersRef.document(id).update(map);
//       return true;
//     } catch (e) {
//       log("Error occurred while getting user data $e");
//       return false;
//     }
//   }

//   // locations functions
//   static Future<void> addNewLocation(BuildContext context, {required Location model, required bool isNew}) async {
//     try {
//       Utils.showLoading(context);
//       if (isNew) {
//         var map = model.toMap();
//         map.remove("id");
//         String locationName = map["location"];
//         List<String> cities = locationName.contains(',') ? locationName.split(',').map((e) => e.trim()).toList() : [locationName.trim()];

//         for (String city in cities) {
//           if (city.isNotEmpty) {
//             var response = await locationsRef.where("location", isEqualTo: city).get();
//             if (response.isEmpty) {
//               await locationsRef.add({"location": city, "modified_by": model.modifiedBy});
//               Utils.showSuccessToast(context, "$city ${"successfully_added".tr}");
//             } else {
//               Utils.showWarningToast(context, "$city ${"already_exist".tr}");
//             }
//           }
//         }
//       } else {
//         if (model.location != "") {
//           var map = model.toMap();
//           String id = map["id"];
//           map.remove("id");
//           await locationsRef.document(id).update(map);
//           Utils.showSuccessToast(context, "successfully_updated".tr);
//         } else {
//           Utils.showWarningToast(context, "location_name_can_not_be_empty".tr);
//         }
//       }
//     } catch (e) {
//       log("Error occurred while adding/updating location $e");
//       Utils.showFailedToast(context, "${"something_went_wrong".tr} $e");
//     } finally {
//       Get.back();
//     }
//   }

//   static Future<RxList<Location>?> getAllLocations(BuildContext context) async {
//     try {
//       var response = await locationsRef.get();
//       if (response.isNotEmpty) {
//         return response
//             .map(
//               (doc) {
//                 var map = doc.map;
//                 map["id"] = doc.id;
//                 return Location.fromMap(map);
//               },
//             )
//             .toList()
//             .obs;
//       } else {
//         Utils.showFailedToast(context, "failed_to_get_locations".tr);
//         return null;
//       }
//     } catch (e) {
//       log("Error occurred while getting items $e");
//       return null;
//     }
//   }

//   // designation functions
//   static Future<void> addNewDesignation(BuildContext context, {required Designation model, required bool isNew}) async {
//     try {
//       Utils.showLoading(context);
//       if (isNew) {
//         var map = model.toMap();
//         map.remove("id");

//         String designationsName = map["designation"];
//         List<String> designations = designationsName.contains(',') ? designationsName.split(',').map((e) => e.trim()).toList() : [designationsName.trim()];

//         for (String designation in designations) {
//           if (designation.isNotEmpty) {
//             var response = await designationsRef.where("designation", isEqualTo: designation).get();
//             if (response.isEmpty) {
//               await designationsRef.add({"designation": designation, "modified_by": model.modifiedBy});
//               Utils.showSuccessToast(context, "$designation ${"successfully_added".tr}");
//             } else {
//               Utils.showWarningToast(context, "$designation ${"already_exist".tr}");
//             }
//           }
//         }
//       } else {
//         if (model.designation != "") {
//           var map = model.toMap();
//           String id = map["id"];
//           map.remove("id");
//           await designationsRef.document(id).update(map);
//           Utils.showSuccessToast(context, "successfully_updated".tr);
//         } else {
//           Utils.showWarningToast(context, "designation_name_can_not_be_empty".tr);
//         }
//       }
//     } catch (e) {
//       log("Error occurred while adding/updating designation $e");
//       Utils.showFailedToast(context, "${"something_went_wrong".tr} $e");
//     } finally {
//       Get.back();
//     }
//   }

//   static Future<RxList<Designation>?> getAllDesignation(BuildContext context) async {
//     try {
//       var response = await designationsRef.get();
//       if (response.isNotEmpty) {
//         return response
//             .map(
//               (doc) {
//                 var map = doc.map;
//                 map["id"] = doc.id;
//                 return Designation.fromMap(map);
//               },
//             )
//             .toList()
//             .obs;
//       } else {
//         Utils.showFailedToast(context, "failed_to_get_designation".tr);
//         return null;
//       }
//     } catch (e) {
//       log("Error occurred while getting items $e");
//       Utils.showFailedToast(context, "${"something_went_wrong".tr} $e");
//       return null;
//     }
//   }

//   // attends
//   static Future<bool> addNewAttendance(BuildContext context, {required Attendance model, required bool isNew}) async {
//     try {
//       if (isNew) {
//         var check = await attendancesRef.where("eid", isEqualTo: model.eid).where("date", isEqualTo: model.date).get();
//         if (check.isNotEmpty) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: MyText(text: "Attendance already exist !"),
//               content: MyText(text: "Do you want to modify existing data ?"),
//               actions: [
//                 TextButton(
//                   onPressed: () => Get.back(result: false),
//                   child: MyText(text: "No"),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     var dataMap = model.toMap();
//                     String id = check.first.id;
//                     dataMap.remove("id");
//                     print(id);
//                     await attendancesRef.document(id).set(dataMap);
//                     Get.back(result: true);
//                   },
//                   child: MyText(
//                     text: "Yes",
//                     style: MyTextStyles.bodyBold.copyWith(color: AppColor.failed),
//                   ),
//                 ),
//               ],
//             ),
//           );

//           return true;
//         } else {
//           var dataMap = model.toMap();
//           dataMap.remove("id");
//           await attendancesRef.add(dataMap);
//           return true;
//         }
//       } else {
//         var dataMap = model.toMap();
//         String id = dataMap["id"];
//         dataMap.remove("id");
//         await attendancesRef.document(id).update(dataMap);
//         return true;
//       }
//     } catch (e) {
//       log("Error occurred while adding new employee $e");
//       return false;
//     }
//   }

//   static Future<bool> addBruteAttendance(BuildContext context, {required Attendance model}) async {
//     try {
//       var check = await attendancesRef.where("eid", isEqualTo: model.eid).where("date", isEqualTo: model.date).get();
//       if (check.isEmpty) {
//         var dataMap = model.toMap();
//         dataMap.remove("id");
//         await attendancesRef.add(dataMap);
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       log("Error occurred while adding new employee $e");
//       return false;
//     }
//   }

//   static Future<RxList<Attendance>?> getAllAttendances(BuildContext context, {DateTime? date}) async {
//     try {
//       DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
//       if (date != null) {
//         var response = await attendancesRef.where("date", isEqualTo: date.millisecondsSinceEpoch).get();
//         if (response.isNotEmpty) {
//           return response
//               .map(
//                 (doc) {
//                   var map = doc.map;
//                   map["id"] = doc.id;
//                   return Attendance.fromMap(map);
//                 },
//               )
//               .toList()
//               .obs;
//         } else {
//           return null;
//         }
//       } else {
//         var response = await attendancesRef.where("date", isEqualTo: currentDate.millisecondsSinceEpoch).get();
//         if (response.isNotEmpty) {
//           return response
//               .map(
//                 (doc) {
//                   var map = doc.map;
//                   map["id"] = doc.id;
//                   return Attendance.fromMap(map);
//                 },
//               )
//               .toList()
//               .obs;
//         } else {
//           return null;
//         }
//       }
//     } catch (e) {
//       log("Error occurred while getting items $e");
//       Utils.showFailedToast(context, "something_went_wrong".tr);
//       return null;
//     }
//   }

//   static Future<bool> deleteAttendance(BuildContext context, {required Attendance model}) async {
//     try {
//       String id = model.id;
//       await attendancesRef.document(id).delete();
//       Utils.showSuccessToast(context, "Deletion successfully");
//       return true;
//     } catch (e) {
//       Utils.showFailedToast(context, "Deletion failed");
//       return false;
//     }
//   }

//   // all editors
//   static Future<RxList<UserDataModel>> getAllUserData(BuildContext context) async {
//     RxList<UserDataModel> attend = <UserDataModel>[].obs;
//     try {
//       if (auth.isSignedIn) {
//         var response = await usersRef.get();
//         if (response.isNotEmpty) {
//           for (var item in response) {
//             var map = item.map;
//             map["id"] = item.id;
//             if (map["eid"] != null && map["eid"] != "") {
//               attend.add(UserDataModel.fromMap(map));
//             }
//           }
//           return attend;
//         } else {
//           Utils.showWarningToast(context, "User Not Found !");
//           return attend;
//         }
//       } else {
//         Utils.showWarningToast(context, "You are not logged in.");
//         return attend;
//       }
//     } catch (e) {
//       log("Error occurred while getting user data $e");
//       return attend;
//     }
//   }

//   // account monitor
//   static Future<RxList<UserDataModel>> getAllMonitorUser(BuildContext context) async {
//     RxList<UserDataModel> attend = <UserDataModel>[].obs;
//     try {
//       if (auth.isSignedIn) {
//         var response = await usersRef.get();
//         if (response.isNotEmpty) {
//           for (var item in response) {
//             var map = item.map;
//             map["id"] = item.id;
//             attend.add(UserDataModel.fromMap(map));
//           }
//           return attend;
//         } else {
//           Utils.showWarningToast(context, "User Not Found !");
//           return attend;
//         }
//       } else {
//         Utils.showWarningToast(context, "You are not logged in.");
//         return attend;
//       }
//     } catch (e) {
//       log("Error occurred while getting user data $e");
//       return attend;
//     }
//   }

//   // reports
//   static Future<List<Attendance>?> getAttendancesSummary(
//     BuildContext context, {
//     required int date,
//     String? eid,
//     String? zone,
//     String? designation,
//     String? attendance,
//   }) async {
//     try {
//       var response = await attendancesRef.where("date", isEqualTo: date).get();

//       if (response.isNotEmpty) {
//         List<Attendance> sourceList = response.map((doc) {
//           final map = doc.map;
//           map["id"] = doc.id;
//           return Attendance.fromMap(map);
//         }).toList();
//         return sourceList.where((item) {
//           if (eid != null && eid.isNotEmpty && item.eid != eid) return false;
//           if (zone != null && zone.isNotEmpty && item.zone != zone) return false;
//           if (designation != null && designation.isNotEmpty && item.designation != designation) return false;
//           if (attendance != null && attendance.isNotEmpty && item.attends != attendance) return false;

//           return true;
//         }).toList();
//       } else {
//         return null;
//       }
//     } catch (e) {
//       log("Error occurred while getting items $e");
//       Utils.showFailedToast(context, "something_went_wrong".tr);
//       return null;
//     }
//   }

//   // summary
//   static Future<List<Attendance>?> getSpecificAttendances(BuildContext context, {required int from, required int to, String? eid, String? zone, String? designation, String? attendance}) async {
//     try {
//       var response = await attendancesRef.where("date", isGreaterThanOrEqualTo: from).where("date", isLessThanOrEqualTo: to).get();
//       if (response.isNotEmpty) {
//         List<Attendance> sourceList = response.map((item) {
//           var map = item.map;
//           map["id"] = item.id;
//           return Attendance.fromMap(map);
//         }).toList();
//         return sourceList.where((item) {
//           // Required date filtering
//           if (item.date < from || item.date > to) return false;

//           // Optional filters
//           if (eid != null && eid.isNotEmpty && item.eid != eid) return false;
//           if (zone != null && zone.isNotEmpty && item.zone != zone) return false;
//           if (designation != null && designation.isNotEmpty && item.designation != designation) return false;
//           if (attendance != null && attendance.isNotEmpty && item.attends != attendance) return false;

//           return true;
//         }).toList();
//       } else {
//         return null;
//       }
//     } catch (e) {
//       log("Error occurred while getting items $e");
//       Utils.showFailedToast(context, "something_went_wrong".tr);
//       return null;
//     }
//   }

//   // performance
//   static Future<bool> addNewPerformance(BuildContext context, Performance model) async {
//     try {
//       var check = await performancesRef.where("eid", isEqualTo: model.eid).get();
//       if (check.isNotEmpty) {
//         var existMap = check[0].map;
//         existMap["id"] = check[0].id;
//         int point = existMap["performance"];
//         existMap["performance"] = point + model.remarks.first.point;
//         (existMap["remarks"] as List).add(model.remarks.first.toMap());
//         await performancesRef.document(existMap["id"]).update(existMap);
//         Utils.showSuccessToast(context, "Performance Updated Successfully ");
//         return true;
//       } else {
//         var map = model.toMap();
//         map.remove("id");
//         map["performance"] = model.performance + model.remarks.first.point;
//         await performancesRef.add(map);
//         Utils.showSuccessToast(context, "Performance Added Successfully ");
//         return true;
//       }
//     } catch (e) {
//       Utils.showFailedToast(context, "Performance Update Failed !");
//       print("Error occurred while updating performance $e");
//       return false;
//     }
//   }

//   static Future<List<Performance>?> getAllPerformance(BuildContext context, {required String eid}) async {
//     try {
//       if (eid.isNotEmpty) {
//         var response = await performancesRef.where("eid", isEqualTo: eid).get();
//         if (response.isNotEmpty) {
//           return response.map((item) {
//             var map = item.map;
//             map["id"] = item.id;
//             return Performance.fromMap(map);
//           }).toList();
//         } else {
//           return null;
//         }
//       } else {
//         var response = await performancesRef.get();
//         if (response.isNotEmpty) {
//           return response.map((item) {
//             var map = item.map;
//             map["id"] = item.id;
//             return Performance.fromMap(map);
//           }).toList();
//         } else {
//           return null;
//         }
//       }
//     } catch (e) {
//       Utils.showFailedToast(context, "Failed to get performances ");
//       return null;
//     }
//   }
// }
