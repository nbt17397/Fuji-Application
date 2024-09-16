import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/home/views/detail_product_view.dart';

import '../../../../config/translations/strings_enum.dart';
import '../../../components/api_error_widget.dart';
import '../../../components/my_widgets_animator.dart';
import '../controllers/home_controller.dart';
import 'widgets/data_grid.dart';
import 'widgets/product_list.dart';
import 'widgets/header.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ----------------------- Header ----------------------- //
          const Header(),

          // ----------------------- Content ----------------------- //
          GetBuilder<HomeController>(builder: (_) {
            return Expanded(
              child: MyWidgetsAnimator(
                apiCallStatus: controller.apiCallStatus,
                loadingWidget: () => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: () => ApiErrorWidget(
                  message: Strings.internetError.tr,
                  retryAction: () => controller.getData(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                successWidget: () => SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductsList(),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AiBarcodeScanner(
                onDispose: () {
                  debugPrint("Barcode scanner disposed!");
                },
                hideGalleryButton: false,
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                ),
                onDetect: (BarcodeCapture capture) {
                  final String? scannedValue = capture.barcodes.first.rawValue;
                  if (scannedValue != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(sku: scannedValue),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
