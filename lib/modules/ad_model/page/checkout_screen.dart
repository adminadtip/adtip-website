import 'dart:convert';
import 'dart:developer';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/ad_model/controllers/ad_models_controller.dart';
import 'package:adtip_web_3/modules/ad_model/page/success_screen.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_web/razorpay_web.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/constants/colors.dart';
import '../../../helpers/constants/razorpay_constant.dart';
import '../../../widgets/button/c_login_button.dart';
import '../skip_video/skip_video_controller.dart';
import '../skip_video/widget/custom_video_player.dart';
import 'package:flutter_razorpay_web/flutter_razorpay_web.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({
    super.key,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool _switchValue = false;
  SkipVideoController skipVideoController =
      Get.put(SkipVideoController(), permanent: true);
  String? couponCode;
  int coupon = 0;
  double gst = 0;
  double finalDelCharge = 0;
  double couponDiscount = 0;
  double delCharge = 0;
  final adModelController = Get.put(AdModelsController());
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              adModelController.title.value,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
                child: Row(
              children: [
                if (skipVideoController.videoUrl.value != null ||
                    skipVideoController.videoUrl.value != "")
                  CachedNetworkImage(
                    imageUrl: skipVideoController.imageUrl.value,
                    width: 90,
                    height: 120,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/noImage.jpg',
                      width: 90,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(adModelController.compaignName.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    Row(
                      children: [
                        Text("₹${adModelController.adValue.value}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 15),
                      height: .5,
                      color: Colors.grey,
                      width: 200,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                insetPadding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                content: SingleChildScrollView(
                                  child: SizedBox(
                                    width: size.width * 0.1,
                                    height: size.height * 0.7,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.cancel),
                                            )),
                                        const SizedBox(height: 10),
                                        if (skipVideoController
                                                .imageUrl.value !=
                                            "")
                                          CachedNetworkImage(
                                            imageUrl: skipVideoController
                                                .imageUrl.value,
                                            fit: BoxFit.fitHeight,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/noImage.jpg',
                                            ),
                                          ),
                                        CustomVideoPlayer(
                                            height: 210,
                                            videoUrl: skipVideoController
                                                .videoUrl.value)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: const Text("preview",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            )),
            const SizedBox(height: 20),
            // const Text("Payment Information",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w600,
            //     )),
            // const SizedBox(height: 5),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             Text('Selected: ',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold, fontSize: 13)),
            //             Text('UPI', style: TextStyle(fontSize: 11))
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Text('Other: ',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold, fontSize: 13)),
            //             Text('Razorpay, paypal, Visa',
            //                 style: TextStyle(fontSize: 11))
            //           ],
            //         )
            //       ],
            //     ),
            //     Icon(Icons.arrow_forward_ios_outlined,
            //         color: Colors.grey.shade500)
            //   ],
            // ),
            const Text("Referral Code",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller:
                          adModelController.referralTextEditingController,
                      onChanged: (value) {
                        adModelController.referralValid.value = false;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Enter Referral Code'),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Obx(() {
                      if (adModelController.checkingReferral.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CLoginButton(
                        title: 'Apply',
                        buttonColor: Colors.black,
                        textColor: Colors.white,
                        showImage: false,
                        onTap: () async {
                          if (adModelController
                              .referralTextEditingController.text.isNotEmpty) {
                            await adModelController.checkReferralCodeValid(
                                code: adModelController
                                    .referralTextEditingController.text
                                    .trim());
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            Obx(
              () => Text(
                adModelController.referralValid.value
                    ? 'Referral code is applied!'
                    : 'Referral code is invalid!',
                style: TextStyle(
                  fontSize: 12,
                  color: adModelController.referralValid.value
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("GST",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    )),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    _switchValue = value;
                    if (value) {
                      setState(() {
                        gst = adModelController.adValue.value * 18 / 100;
                        _switchValue = value;
                      });
                    } else {
                      setState(() {
                        gst = 0;
                        _switchValue = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Payment details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Value', style: TextStyle(fontSize: 13)),
                Text('₹ ${adModelController.adValue.value}',
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery charge 20%',
                    style: TextStyle(fontSize: 13)),
                Text('₹ ${finalDelCharge.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 5),
            Obx(
              () => adModelController.referralValid.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Coupon Applied -5%',
                            style: TextStyle(fontSize: 13)),
                        Text(
                            '- ₹ ${(adModelController.adValue.value * 5 / 100).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold))
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 5),
            _switchValue
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('GST 18%', style: TextStyle(fontSize: 13)),
                      Text('₹ ${gst.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))
                    ],
                  )
                : const SizedBox.shrink(),
            const Divider(),
            const SizedBox(height: 15),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 13)),
                    Text(
                        '₹ ${(adModelController.adValue.value - (adModelController.referralValid.value ? adModelController.adValue.value * 5 / 100 : 0) + gst + finalDelCharge).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold))
                  ],
                )),
            const SizedBox(height: 20),
            Obx(
              () => skipVideoController.loadingThird.value
                  ? const Center(child: CircularProgressIndicator())
                  : CLoginButton(
                      title: 'Book',
                      onTap: () {
                        double totalAmount = adModelController.adValue.value +
                            gst +
                            finalDelCharge -
                            (adModelController.referralValid.value
                                ? adModelController.adValue * 5 / 100
                                : 0);
                        int totalMainAmount = (totalAmount * 100).toInt();
                        log(
                          totalMainAmount.toString(),
                        );
                        Map<String, dynamic> paymentData = {
                          'amount':
                              totalMainAmount, // amount in paise (e.g., 1000 paise = Rs. 10)
                          'currency': 'INR',
                          'receipt': 'order_receipt',
                          'payment_capture': '1',
                        };
                        initiatePayment(
                          paymentData: paymentData,
                          name: adModelController.compaignName.value,
                        );
                      },
                      buttonColor: AdtipColors.black,
                      textColor: AdtipColors.white,
                      showImage: false,
                    ),
            ),
            CLoginButton(
              title: 'Back',
              onTap: () {
                dashboardController.changeWidget(value: 14);
              },
              buttonColor: AdtipColors.white,
              textColor: AdtipColors.black,
              showImage: false,
            ),
          ],
        ),
      ),
    );
  }

  //rozer pay function
  late Razorpay _razorpay;
  // late RazorpayWeb _razorpay;

  // final _razorpay = Razorpay();
  //
  // Map<String, dynamic> paymentData = {
  //   'amount': (widget.orderValue +
  //       gst +
  //       finalDelCharge), // amount in paise (e.g., 1000 paise = Rs. 10)
  //   'currency': 'INR',
  //   'receipt': 'order_receipt',
  //   'payment_capture': '1',
  // };

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onCancel);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onFailed);
    delCharge = ((.2) * adModelController.adValue.value);
    finalDelCharge = delCharge;
    gst = _switchValue ? (.18 * (adModelController.adValue.value)) : 0;
    super.initState();
    adModelController.getReferralCode();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void _onSuccess(PaymentSuccessResponse response) {
    _handlePaymentSuccess();
  }

  void _onCancel(PaymentFailureResponse response) {
    Utils.showErrorMessage('Error ${response.message}');
  }

  void _onFailed(PaymentFailureResponse response) {
    Utils.showErrorMessage('Error ${response.message}');
  }

  void _handlePaymentSuccess() {
    skipVideoController.saveThirdPageAdModel(
        adDescription: adModelController.description.value,
        adOrderValue: adModelController.adValue.value.toStringAsFixed(2),
        adChargesValue: finalDelCharge.toStringAsFixed(2),
        adCompanyLocation: adModelController.location.value,
        adCoupan: adModelController.referralValid.value
            ? adModelController.referralCodeToUse.value
            : null,
        adPaymendMode: "UPI",
        adPlaceApp: "Delhi",
        adRefferal: adModelController.referralValid.value
            ? adModelController.referralCreator.value
            : null,
        adTax: gst.toStringAsFixed(2),
        adTaxNumber: adModelController.tax.value,
        adWebsite: adModelController.website.value,
        adWebsiteLink: adModelController.website.value,
        adTotal: (adModelController.adValue.value -
                (adModelController.referralValid.value
                    ? adModelController.adValue.value * 5 / 100
                    : 0) +
                gst +
                finalDelCharge)
            .toString(),
        onSuccess: () {
          dashboardController.changeWidget(value: 16);

          //Get.to(const SuccessScreen());
        });
    // Do something when payment succeeds
    // Here we get razorpay_payment_id razorpay_order_id razorpay_signature
  }

  Future<void> initiatePayment(
      {required Map<String, dynamic> paymentData, required String name}) async {
    var options = {
      'key': AppConstent.apiKeyRozer,
      'amount': paymentData['amount'],
      'name': name,
      // 'order_id': uuid.v4(),
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm'] // optional, for adding support for wallets
      }
    };

    // Open the Razorpay payment form
    _razorpay.open(options);
  }
}
