import 'dart:io';
import 'dart:ui';

import 'package:ae_kits/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRCodeServices {
  static void generateQRCodeImage(BuildContext context, {required String data, required String filename}) async {
    try {
      final qrCode = QrCode.fromData(
        data: data,
        errorCorrectLevel: QrErrorCorrectLevel.H,
      );

      final qrImage = QrImage(qrCode);
      final qrImageBytes = await qrImage.toImageAsBytes(
        size: 512,
        format: ImageByteFormat.png,
        decoration: const PrettyQrDecoration(),
      );

      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/$filename.png");
      file.writeAsBytes(qrImageBytes!.buffer.asUint8List());
      Utils.showSuccessToast(context, "Saved successfully !");
    } catch (e) {
      Utils.showFailedToast(context, "Failed to save !\n$e");
    }
  }
}
