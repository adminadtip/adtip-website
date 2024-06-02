import 'dart:developer';
import 'dart:html' as html;
import 'dart:io';
import 'dart:ui' as ui;
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/qr_ad_display/pages/qr_ad_web_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/constants/Loader.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controllers/order_controller.dart';
import 'ad_tracking.dart';
import 'graph/leadscreen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrdersController orderController = Get.put(OrdersController());
  final dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    orderController.getOrderList();

    // orderController.getOrderList();
  }

  final riKey1 = const Key('__RIKEY1__');

  DashboardController dashBoardController = Get.put(DashboardController());
  ScreenshotController screenshotController = ScreenshotController();
  bool qrShow = false;
  // String generateQrData() {return ""}
  // GlobalKey _globalKey = GlobalKey();
  static GlobalKey previewContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 700,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Obx(
          () {
            if (orderController.loading.value) {
              return const Loader();
            }
            if (orderController.orderListData.isEmpty) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/blank.png'),
                    const SizedBox(height: 10),
                    const Text(
                      'No Ad ordered yet',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You haven’t booked any ad yet.',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CLoginButton(
                      title: "Book Ad",
                      onTap: () {
                        dashBoardController.changeWidget(value: 11);
                      },
                      buttonColor: AdtipColors.black,
                      textColor: AdtipColors.white,
                      showImage: false,
                    )
                  ]);
            }
            if (kDebugMode) {
              print(
                  'ad name ${orderController.orderListData[0].adUploadOriginalFilename} ${orderController.orderListData[0].id}');
            }
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ad orders',
                      style: TextStyle(
                        color: Color(0xFF001E2F),
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    String? format = orderController
                        .orderListData[i].adUploadFilename
                        ?.split(".")
                        .last;
                    return Card(
                        child: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          height: 120,
                        ),
                        // if (format == 'mp4' ||
                        //     format == 'mov' ||
                        //     format == 'avi' ||
                        //     format == 'm4v' ||
                        //     format == '3gp')
                        //   CachedNetworkImage(
                        //     imageUrl: orderController
                        //         .orderListData[i].adUploadFilename
                        //         .toString()
                        //         .trim(),
                        //     width: 100,
                        //     height: 120,
                        //     fit: BoxFit.fill,
                        //     placeholder: (context, url) => const Center(
                        //         child: CircularProgressIndicator()),
                        //     errorWidget: (context, url, error) => Image.asset(
                        //       'assets/images/noImage.jpg',
                        //       width: 100,
                        //       height: 120,
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      orderController.orderListData[i]
                                                  .campaignName !=
                                              null
                                          ? orderController.orderListData[i]
                                                      .campaignName ==
                                                  "null"
                                              ? ""
                                              : (orderController
                                                      .orderListData[i]
                                                      .campaignName ??
                                                  "")
                                          : "",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  if (orderController
                                              .orderListData[i].adModelId ==
                                          5 ||
                                      orderController
                                              .orderListData[i].adModelId ==
                                          4)
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                text:
                                                    'https://adtip.in/mob/QRImageAd/?url=${Uri.encodeComponent(orderController.orderListData[i].adUploadOriginalFilename)}&companyId=${Uri.encodeComponent(orderController.orderListData[i].companyId.toString())}&adId=${Uri.encodeComponent(orderController.orderListData[i].id.toString())}',
                                              )).then((_) {
                                                Utils.showSuccessMessage(
                                                    'Qr Code link copied');
                                              });
                                            },
                                            icon: const Icon(Icons.copy)),
                                        Center(
                                          child: QrImageView(
                                            data:
                                                'https://adtip.in/mob/QRImageAd/?url=${Uri.encodeComponent(orderController.orderListData[i].adUploadOriginalFilename)}&companyId=${Uri.encodeComponent(orderController.orderListData[i].companyId.toString())}&adId=${Uri.encodeComponent(orderController.orderListData[i].id.toString())}',
                                            // data:
                                            //     "${orderController.orderListData[i].adUploadOriginalFilename}",
                                            size: 45,
                                            version: QrVersions.auto,
                                            gapless: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  // ),
                                  InkWell(
                                      onTap: () async {
                                        showAlertDialog(
                                          context,
                                          onTap: () async {
                                            _saveLocalImage(
                                              context,
                                              orderController
                                                  .orderListData[i].id,
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          title: "title",
                                          subTitle: "subTitle",
                                          index: i,
                                          size: size,
                                        );

                                        setState(() {
                                          qrShow = true;
                                        });
                                      },
                                      child: const Icon(Icons.download)),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Get.to(AdTrackingPage());
                                  //   },
                                  //   child: Text(
                                  //     'Track',
                                  //     style: TextStyle(
                                  //       color: Color(0xFF9A2042),
                                  //       fontSize: 16.sp,
                                  //       fontWeight: FontWeight.w700,
                                  //       decoration: TextDecoration.underline,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 13),
                                  Text(
                                    '₹ ${orderController.orderListData[i].adOrderValue.toStringAsFixed(2) ?? 0}',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  SizedBox(
                                    width: size.width * 0.3,
                                    child: Text(
                                      orderController.orderListData[i].name,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 1,
                                color: Colors.grey,
                                width: 210,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      orderController.changeOrderIndex(
                                          index: i,
                                          orderId: orderController
                                              .orderListData[i].id);
                                      dashboardController.changeWidget(
                                          value: 10);
                                    },
                                    child: const Text(
                                      'Track',
                                      style: TextStyle(
                                        color: Color(0xFF9A2042),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  if (orderController
                                              .orderListData[i].adModelId ==
                                          5 ||
                                      orderController
                                              .orderListData[i].adModelId ==
                                          4)
                                    InkWell(
                                      onTap: () {
                                        Get.to(QrAdWebData(
                                          adId: orderController
                                              .orderListData[i].id,
                                        ));
                                      },
                                      child: const Text(
                                        'QR Code Ad Analytics',
                                        style: TextStyle(
                                          color: Color(0xFF9A2042),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    onTap: () {
                                      Get.to(MyLeadPage(
                                          compaginId: orderController
                                              .orderListData[i].id,
                                          compaignName: orderController
                                              .orderListData[i].campaignName));
                                    },
                                    child: const Text('ANALYTICS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF635CB5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
                  },
                  separatorBuilder: (context, i) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: orderController.orderListData.length,
                ),
                const SizedBox(
                  height: 20,
                ),
                CLoginButton(
                  title: 'Back',
                  onTap: () {
                    dashboardController.changeWidget(value: 0);
                  },
                  buttonColor: AdtipColors.white,
                  textColor: AdtipColors.black,
                  showImage: false,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void downloadQrCode(String data, String fileName) async {
    // Create a QR code painter
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
        gapless: false,
      );

      // Convert QR code to image data
      final imageData = await painter.toImageData(200);
      if (imageData != null) {
        final pngBytes = imageData.buffer.asUint8List();
        final blob = html.Blob([pngBytes], 'image/png');
        final url = html.Url.createObjectUrlFromBlob(blob);

        // Create an anchor element and trigger the download
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        html.Url.revokeObjectUrl(url);

        // Show a snackbar notification
        Get.snackbar(
          'Download is done successfully',
          '',
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }
    } else {
      Get.snackbar(
        'QR Code generation failed',
        '',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future _saveLocalImage(context, id) async {
    try {
      // final boundary = previewContainer.currentContext!.findRenderObject()
      //     as RenderRepaintBoundary;
      // final image = await boundary.toImage();
      // final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      // final pngBytes = byteData?.buffer.asUint8List();
      // print('bytes $pngBytes');
      // final blob = html.Blob([pngBytes]);
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // final anchor = html.AnchorElement(href: url)
      //   ..setAttribute("download", "generated_image$id.png")
      //   ..click();
      // html.Url.revokeObjectUrl(url);
      // Get.snackbar("Download is done successfully", "",
      //     colorText: Colors.white, backgroundColor: Colors.green);
      // setState(() {
      //   qrShow = false;
      // });
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          final blob = html.Blob([image]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", "generated_image$id.png")
            ..click();
          html.Url.revokeObjectUrl(url);
          Get.snackbar("Download is done successfully", "",
              colorText: Colors.white, backgroundColor: Colors.green);
          setState(() {
            qrShow = false;
          });
        }
      }).catchError((onError) {
        print('Error --->> $onError');
      });
    } on PlatformException catch (err) {
      print(err);
    } catch (err) {
      print(err);
    }
  }

  void showAlertDialog(BuildContext context,
      {required Function() onTap,
      required String title,
      required String subTitle,
      required int index,
      required Size size}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
        onPressed: () async {
          // downloadQrCode(
          //     'https://adtip.in/mob/QRImageAd/?url=${Uri.encodeComponent(orderController.orderListData[index].adUploadOriginalFilename)}&companyId=${Uri.encodeComponent(orderController.orderListData[index].companyId.toString())}&adId=${Uri.encodeComponent(orderController.orderListData[index].id.toString())}',
          //     'qrcode');
          await _saveLocalImage(
              context, orderController.orderListData[index].id);
          Navigator.of(context).pop();
        },
        child: const Text("Download Now", style: TextStyle(fontSize: 16)));
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 200,
        height: 100,
        child: GetBuilder<OrdersController>(builder: (ordersControllerWidget) {
          return Center(
            child: Screenshot(
              key: riKey1,
              controller: screenshotController,
              child: RepaintBoundary(
                key: previewContainer,
                child: QrImageView(
                  backgroundColor: Colors.white,
                  data:
                      'https://adtip.in/mob/QRImageAd/?url=${Uri.encodeComponent(orderController.orderListData[index].adUploadOriginalFilename)}&companyId=${Uri.encodeComponent(orderController.orderListData[index].companyId.toString())}&adId=${Uri.encodeComponent(orderController.orderListData[index].id.toString())}',
                  // data:
                  //     "${ordersControllerWidget.orderListData[index].adUploadOriginalFilename}${orderController.orderListData[index].companyId}",
                  size: 200,
                  version: QrVersions.auto,
                  gapless: false,
                ),
              ),
            ),
          );
        }),
      ),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
