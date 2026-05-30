import 'package:ae_kits/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final storage = FlutterSecureStorage(
    webOptions: WebOptions(dbName: "AE-Kits", publicKey: "ae_kits"),
  );

  static Future<bool> write(
    BuildContext context, {
    required String key,
    required dynamic value,
  }) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e) {
      print(e.toString());
      Utils.showFailedToast(context, "Failed to write");
      return false;
    }
  }

  static Future<String?> read(
    BuildContext context, {
    required String key,
  }) async {
    try {
      var result = await storage.read(key: key);
      return result;
    } catch (e) {
      Utils.showFailedToast(context, "Failed to read");
      return null;
    }
  }

  static Future<bool> delete(
    BuildContext context, {
    required String key,
  }) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (e) {
      Utils.showFailedToast(context, "Failed to delete");
      return false;
    }
  }

  static Future<bool> containsKey(
    BuildContext context, {
    required String key,
  }) async {
    try {
      bool containsKey = await storage.containsKey(key: key);
      return containsKey;
    } catch (e) {
      Utils.showFailedToast(context, "Key does not exist");
      return false;
    }
  }
}
