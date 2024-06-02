import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/Loader.dart';
import '../../../helpers/constants/colors.dart';
import '../controllers/order_controller.dart';
import '../models/order_list.dart';
import '../controllers/ad_track_cont.dart';

class AdTrackingPage extends StatefulWidget {
  const AdTrackingPage({super.key});

  @override
  State<AdTrackingPage> createState() => _AdTrackingPageState();
}

bool? _switchValue;

class _AdTrackingPageState extends State<AdTrackingPage> {
  int currentStep = 1;
  AdTrackingOrder adTrackingOrder = Get.put(AdTrackingOrder());
  final OrdersController orderController = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    onOff();
  }

  String? format;
  Future onOff() async {
    await adTrackingOrder.getTrackingDetails(
        orderId: orderController.selectedOrderId.value);
    setState(() {
      _switchValue =
          adTrackingOrder.trackingOrderData.first.adPauseCountinue == 1
              ? true
              : false;
    });
    format = adTrackingOrder.trackingOrderData.first.adUploadFilename
        ?.split(".")
        .last;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20),
        child: Obx(
          () {
            if (adTrackingOrder.loading.value) {
              return const Loader();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Total ad value - ₹ ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.adOrderValue}/-',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Per ad Lead Cost - ₹ ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: adTrackingOrder
                                    .trackingOrderData.first.perLeadCost
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Per day reach views -  ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.adCustomerTargetPerDay}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Ad per view cost  - ₹ ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.adPerViewCost ?? ""}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Ad per Like cost - ₹ ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.adPerLikeCost}/-',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'no of days ad campaign - ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.totalDays} days',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'No of days completed - ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.noOfDaysCompleted} days',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Total view till now - ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.totalViews}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Total Like till now - ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.totalLikes}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Total Available Balance - ₹ ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${adTrackingOrder.trackingOrderData.first.totalAvailableBalance}/-',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    trackColor: Colors.red,
                    // offLabelColor: Colors.red,
                    value: _switchValue ?? true,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                      adTrackingOrder.pauseStartOrder(
                          id: orderController.selectedOrderId.value.toString(),
                          adPauseContinue: _switchValue == true ? "1" : "0",
                          onSuccess: () {
                            onOff();
                          });
                    },
                  ),
                ),
                _switchValue == false
                    ? const Text(
                        'Pause',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 5, backgroundColor: Colors.green),
                          SizedBox(width: 5),
                          Text(
                            "Live",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                track(
                  value: true,
                  title: 'Ad Ordered',
                  subTitle: adTrackingOrder.trackingOrderData.first.createddate
                      .toString()
                      .substring(
                        0,
                        10,
                      ),
                ),
                track(
                    value: true,
                    title: 'Admin Approval',
                    subTitle:
                        '${adTrackingOrder.trackingOrderData.first.adminApproval} '),
                track(
                    value: true,
                    title: 'Campaign Start Date',
                    subTitle: adTrackingOrder
                        .trackingOrderData.first.adStartDate
                        .toString()
                        .substring(0, 10)),
                track(
                  value: true,
                  title: 'Campaign Start Now',
                  subTitle: adTrackingOrder.trackingOrderData.first.adEndDate
                      .toString()
                      .substring(
                        0,
                        10,
                      ),
                  // value: myStartDate(),
                ),
                // track(
                //     title: 'Campaign Start Now',
                //     subTitle: adTrackingOrder
                //         .trackingOrderData.first.adStartDate
                //         .toString()
                //         .substring(0, 10)),
                // trackPending(
                //     title: 'Campaign Start Now',
                //     subTitle: adTrackingOrder
                //         .trackingOrderData.first.adStartDate
                //         .toString()
                //         .substring(0, 10)),
                track(
                    value: true,
                    title:
                        '${adTrackingOrder.trackingOrderData.first.reachSuccessfull} - Reach Successful',
                    subTitle: ''),

                track(
                    title:
                        '${adTrackingOrder.trackingOrderData.first.reachPending} - Reach Pending',
                    subTitle: '',
                    value: true),
                track(
                    isLine: false,
                    title: 'Order Successfull',
                    subTitle: '',
                    value: adTrackingOrder
                        .trackingOrderData.first.orderSuccessfull!),
                // Row(
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.only(left: 22),
                //       alignment: Alignment.centerLeft,
                //       child: const CircleAvatar(
                //         radius: 10,
                //         backgroundColor: AdtipColors.black,
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     const Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Order Successful',
                //           style: TextStyle(
                //               color: Color(0xFF474747),
                //               fontSize: 14,
                //               fontWeight: FontWeight.w700,
                //               height: -.1),
                //         ),
                //         SizedBox(height: 4),
                //         Text(
                //           'Done',
                //           style: TextStyle(
                //             color: Color(0xFF747474),
                //             fontSize: 12,
                //             fontWeight: FontWeight.w400,
                //           ),
                //         )
                //       ],
                //     )
                //   ],
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget track(
      {required String title,
      required String subTitle,
      bool value = false,
      bool isLine = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? AdtipColors.black : AdtipColors.white,
                    border: Border.all(color: Colors.black)),
              ),
              // CircleAvatar(
              //   radius: 10,
              //   backgroundColor: value ? AdtipColors.black : AdtipColors.white,
              // ),
              if (isLine)
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  color: Colors.black,
                  width: 1,
                  height: 40,
                )
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Color(0xFF747474),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget trackPending({required String title, required String subTitle}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 10,
                backgroundColor: AdtipColors.black,
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: AdtipColors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                color: Colors.black,
                width: 1,
                height: 40,
              )
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Color(0xFF747474),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  bool myStartDate() {
    DateTime parsedDate =
        DateTime.parse(adTrackingOrder.trackingOrderData.first.adStartDate!);
    if (parsedDate.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
