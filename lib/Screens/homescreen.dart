import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';
import 'package:qrscanner/controllers/barcode_controller.dart'; // For copying to clipboard

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final BarcodeController barcode = Get.put(BarcodeController());

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "QR Scanner App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Icon(
                Icons.qr_code,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        height: Get.height * 1,
        width: Get.width * 1,
        child: Column(
          children: [
            Container(
              width: Get.width * 1,
              height: Get.height * 0.15,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const Text(
                    "Scan QR Code",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.blue),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  const Text(
                    "Hold Your Device over a QR Code to scan",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    "Tap the pop-up notification",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Container(
              height: Get.height * 0.4,
              width: Get.width * 1,
              child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    returnImage:
                        true, // No need to return image for QR detection
                  ),
                  onDetect: (capture) {
                    barcode.onDetect(capture);
                  }),

              // Show the dialog when the first barcode is detec
            ),
          ],
        ),
      ),
    );
  }
}
