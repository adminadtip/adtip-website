import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrdersController orderController = Get.put(OrdersController());
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
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
                            Get.back();
                          },
                          buttonColor: AdtipColors.black,
                          textColor: AdtipColors.white,
                          showImage: false,
                        )
                      ]);
                }
                print(
                    'ad name ${orderController.orderListData[0].adUploadOriginalFilename} ${orderController.orderListData[0].id}');
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ad orders',
                          style: TextStyle(
                            color: Color(0xFF001E2F),
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => ContactUsPage(),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'Customer care',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF261AAC),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 0,
                            ),
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
                        print(
                            "${orderController.orderListData[i].adUploadFilename}8888");
                        return Card(
                            child: Row(
                          children: [
                            if (format == 'mp4' ||
                                format == 'mov' ||
                                format == 'avi' ||
                                format == 'm4v' ||
                                format == '3gp')
                              // FutureBuilder(
                              //     future: orderController.genThumbnailFile(
                              //         path: orderController.orderListData[i]
                              //                     .adUploadFilename !=
                              //                 null
                              //             ? orderController
                              //                 .orderListData[i].adUploadFilename
                              //                 .toString()
                              //                 .trim()
                              //             : ""),
                              //     builder: (context, snapshot) {
                              //       if (snapshot.data?.path == "") {
                              //         return Image.asset(
                              //           'assets/images/noImage.jpg',
                              //           width: 100.w,
                              //           height: 120.h,
                              //           fit: BoxFit.fill,
                              //         );
                              //       }
                              //       if (snapshot.hasData) {
                              //         return Image.file(
                              //           snapshot.data!,
                              //           width: 100.w,
                              //           height: 120.h,
                              //           fit: BoxFit.fill,
                              //         );
                              //       }
                              //       return Container(
                              //           width: 100.w,
                              //           height: 120.h,
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             children: const [
                              //               CircularProgressIndicator(),
                              //             ],
                              //           ));
                              //     })

                              CachedNetworkImage(
                                imageUrl: orderController
                                    .orderListData[i].adUploadFilename
                                    .toString()
                                    .trim(),
                                width: 100,
                                height: 120,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/noImage.jpg',
                                  width: 100,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
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
                                      SizedBox(width: 50),
                                      // if (qrShow)
                                      //   Center(
                                      //     child: Screenshot(
                                      //       key: riKey1,
                                      //       controller: screenshotController,
                                      //       child: QrImageView(
                                      //         backgroundColor: Colors.white,
                                      //         data: orderController.orderListData[i]
                                      //             .adUploadOriginalFilename,
                                      //         size: 45.h,
                                      //         version: QrVersions.auto,
                                      //         gapless: false,
                                      //       ),
                                      //     ),
                                      //   ),
                                      if (orderController
                                                  .orderListData[i].adModelId ==
                                              5 ||
                                          orderController
                                                  .orderListData[i].adModelId ==
                                              4)
                                        // Obx(
                                        //   () =>

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
                                          child: Icon(Icons.download)),
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
                                        '₹ ${orderController.orderListData[i].adTotal != null ? orderController.orderListData[i].adTotal.toStringAsFixed(2) ?? 0 : 0}',
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
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                          // Get.to(AdTrackingPage(
                                          //     orderId: orderController
                                          //         .orderListData[i]));
                                        },
                                        child: const Text(
                                          'Track',
                                          style: TextStyle(
                                            color: Color(0xFF9A2042),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      //   'PREVIEW',
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: Color(0xFF1554F6),
                                      //     fontSize: 14.sp,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                      const SizedBox(width: 20),
                                      InkWell(
                                        onTap: () {
                                          log(
                                              orderController
                                                  .orderListData[i].id
                                                  .toString(),
                                              name: "adidhere");
                                          // Get.to(MyLeadPage(
                                          //     compaginId: orderController
                                          //         .orderListData[i].id,
                                          //     compaignName: orderController
                                          //         .orderListData[i].campaignName));
                                        },
                                        child: const Text('ANALYTICS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF635CB5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      SizedBox(width: 50),
                                      InkWell(
                                        onTap: () {
                                          // _shareQrCode(
                                          //     orderController.orderListData[i].id);
                                          // setState(() {
                                          //   qrShow = true;
                                          // });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Icon(Icons.share),
                                        ),
                                      )
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
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future _saveLocalImage(context, id) async {
    try {
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final imageFile = await File('$directory/$fileName.png').create();
      // screenshotController.capture().then((Uint8List? image) async {
      screenshotController.capture().then((Uint8List? image) async {
        print('$image   rule 436');
        log(
          "started",
        );
        if (image != null) {
          try {
            await imageFile.writeAsBytes(image);
            // await ImageGallerySaver.saveFile(
            //   imageFile.path,
            //   isReturnPathOfIOS: true,
            // );
            Get.snackbar("Download is done successfully", "",
                colorText: Colors.white, backgroundColor: Colors.green);
            setState(() {
              qrShow = false;
            });
          } catch (error) {}
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
        onPressed: onTap,
        child: const Text("Download Now", style: TextStyle(fontSize: 16)));
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.45,
        child: GetBuilder<OrdersController>(builder: (ordersControllerWidget) {
          return Center(
            child: Screenshot(
              key: riKey1,
              controller: screenshotController,
              child: QrImageView(
                backgroundColor: Colors.white,
                data:
                    'https://adtip.in/mob/QRImageAd/?url=${Uri.encodeComponent(orderController.orderListData[index].adUploadOriginalFilename)}&companyId=${Uri.encodeComponent(orderController.orderListData[index].companyId.toString())}&adId=${Uri.encodeComponent(orderController.orderListData[index].id.toString())}',
                // data:
                //     "${ordersControllerWidget.orderListData[index].adUploadOriginalFilename}${orderController.orderListData[index].companyId}",
                size: size.width * 0.8,
                version: QrVersions.auto,
                gapless: false,
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

  Future _shareQrCode(id) async {
    print('$id rule 56');
    try {
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final imageFile = await File('$directory/$fileName.png').create();
      screenshotController.capture().then((Uint8List? image) async {
        print('$image rule 436');
        if (image != null) {
          try {
            await imageFile.writeAsBytes(image);
            Share.shareFiles([imageFile.path]);
            setState(() {
              qrShow = false;
            });
          } catch (error) {}
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
}
