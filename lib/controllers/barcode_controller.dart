import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeController extends GetxController {
  var scannedQRCode = ''.obs;
  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      // Update the scanned QR code with the first detected barcode's raw value
      scannedQRCode.value = barcodes.first.rawValue ?? 'Unknown QR code';
      Get.defaultDialog(
        titlePadding: EdgeInsets.all(12),
        title: "QR Code Detected",titleStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blue),
        contentPadding: const EdgeInsets.all(12),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("QR Code: ${scannedQRCode}"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (scannedQRCode != null) {
                Clipboard.setData(
                    ClipboardData(text: scannedQRCode.toString()));
                Get.snackbar("Copied", "QR Code copied to clipboard!",
                    snackPosition: SnackPosition.BOTTOM,
                    padding: const EdgeInsets.all(12),
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 159, 212, 255), // Button color
            ),
            child: const Text("Copy"),
          ),
          SizedBox(width: Get.width*0.01,),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 202, 230, 255), // Button color
            ),
            child: const Text("Ok"),
          ),
        ],
      );
    }
  }
}
