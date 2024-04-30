import 'dart:convert';
import 'dart:developer';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/ad_model/page/success_screen.dart';
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
  final String tax;
  final String loc;
  final String website;
  final String des;
  final int orderValue;
  final String campaign;
  final String name;

  const CheckOutScreen({
    super.key,
    required this.des,
    required this.loc,
    required this.tax,
    required this.website,
    required this.orderValue,
    required this.campaign,
    required this.name,
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ordering Ad model",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 5),
                Card(
                    child: Row(
                  children: [
                    if (skipVideoController.videoUrl.value != null ||
                        skipVideoController.videoUrl.value != "")
                      //   FutureBuilder(
                      //       future: skipVideoController
                      //           .genThumbnailFile(skipVideoController.videoUrl.value),
                      //       builder: (context, snapshot) {
                      //         if (snapshot.hasData) {
                      //           return Image.file(
                      //             snapshot.data!,
                      //             width: 90,
                      //             height: 120,
                      //             fit: BoxFit.fill,
                      //           );
                      //         }
                      //         return const SizedBox(
                      //             width: 90,
                      //             height: 120,
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 CircularProgressIndicator(),
                      //               ],
                      //             ));
                      //       })
                      // else
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
                    // Image.asset(
                    //   'assets/extra/Thumbnail_(2).png',
                    //   width: 70.w,
                    //   height: 110.h,
                    //   fit: BoxFit.cover,
                    // ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(widget.campaign,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            )),
                        Row(
                          children: [
                            Text("₹${widget.orderValue}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(width: 5),
                            const Text(
                              "Celebration Status",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 10, bottom: 15),
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
                const Text("Payment Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Selected: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),
                            Text('UPI', style: TextStyle(fontSize: 11))
                          ],
                        ),
                        Row(
                          children: [
                            Text('Other: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),
                            Text('Razorpay, paypal, Visa',
                                style: TextStyle(fontSize: 11))
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.grey.shade500)
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // Get.to(CouponScreen())?.then((value) {
                    //   setState(() {
                    //     couponCode = value.couponCode;
                    //     coupon = value.couponDiscount;
                    //   });
                    //   print(value.couponCode);
                    // });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Apply coupon",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey.shade500,
                        size: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (couponCode != null)
                          Row(
                            children: [
                              const Text('Added: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              Text(couponCode ?? "",
                                  style: const TextStyle(fontSize: 11))
                            ],
                          ),
                        // Row(
                        //   children: [
                        //     Text('More: ',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 13.sp)),
                        //     Text('HDFC30, NEW50, FIRST70',
                        //         style: TextStyle(fontSize: 11.sp))
                        //   ],
                        // )
                      ],
                    ),
                  ],
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
                        setState(() {
                          _switchValue = value;
                        });
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
                    Text('₹ ${widget.orderValue}',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Delivery charge ${coupon != 0 ? ((coupon * 30) / 100) : 30}%',
                        style: const TextStyle(fontSize: 13)),
                    Text('₹ ${finalDelCharge.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold))
                  ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 13)),
                    Text(
                        '₹ ${(widget.orderValue + gst + finalDelCharge).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () => skipVideoController.loadingThird.value
                      ? const Center(child: CircularProgressIndicator())
                      : CLoginButton(
                          title: 'Book',
                          onTap: () {
                            print((widget.orderValue + gst + finalDelCharge)
                                    .toString() +
                                'amount');

                            double totalAmount =
                                widget.orderValue + gst + finalDelCharge;
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
                              name: widget.name,
                            );
                            // skipVideoController.saveThirdPageAdModel(
                            //     adDescription: widget.des,
                            //     adOrderValue: widget.orderValue.toStringAsFixed(2),
                            //     adChargesValue: finalDelCharge.toStringAsFixed(2),
                            //     adCompanyLocation: widget.loc,
                            //     adCoupan: "Test",
                            //     adPaymendMode: "UPI",
                            //     adPlaceApp: "Delhi",
                            //     adRefferal: "TEST",
                            //     adTax: gst.toStringAsFixed(2),
                            //     adTaxNumber: widget.tax,
                            //     adWebsite: widget.website,
                            //     adWebsiteLink: widget.website,
                            //     adTotal: (widget.orderValue + gst + finalDelCharge)
                            //         .toString(),
                            //     onSuccess: () {
                            //       Get.to(SuccessScreen());
                            //     });
                          },
                          buttonColor: AdtipColors.black,
                          textColor: AdtipColors.white,
                          showImage: false,
                        ),
                ),
                CLoginButton(
                  title: 'Back',
                  onTap: () {
                    Get.back();
                  },
                  buttonColor: AdtipColors.white,
                  textColor: AdtipColors.black,
                  showImage: false,
                ),
              ],
            ),
          ),
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
    // _razorpay = RazorpayWeb(
    //   onSuccess: _onSuccess,
    //   onCancel: _onCancel,
    //   onFailed: _onFailed,
    // );
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onCancel);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onFailed);
    delCharge = ((.3) * widget.orderValue);
    couponDiscount = delCharge * (coupon / 100);
    finalDelCharge = delCharge - couponDiscount;
    gst = _switchValue ? (.18 * (widget.orderValue)) : 0;
    super.initState();
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
        adDescription: widget.des,
        adOrderValue: widget.orderValue.toStringAsFixed(2),
        adChargesValue: finalDelCharge.toStringAsFixed(2),
        adCompanyLocation: widget.loc,
        adCoupan: "Test",
        adPaymendMode: "UPI",
        adPlaceApp: "Delhi",
        adRefferal: "TEST",
        adTax: gst.toStringAsFixed(2),
        adTaxNumber: widget.tax,
        adWebsite: widget.website,
        adWebsiteLink: widget.website,
        adTotal: (widget.orderValue + gst + finalDelCharge).toString(),
        onSuccess: () {
          Get.to(const SuccessScreen());
        });
    // Do something when payment succeeds
    // Here we get razorpay_payment_id razorpay_order_id razorpay_signature
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('error payment ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  // void initiatePayment(
  //     {required Map<String, dynamic> paymentData, required String name}) {
  //   var uuid = const Uuid();
  //   _makePayment(
  //     amount: paymentData['amount'].toString(),
  //     orderId: uuid.v4(),
  //     keyId: AppConstent.apiSecretRozer,
  //   );
  // }
  //
  // void _makePayment({
  //   required String amount,
  //   required String orderId,
  //   required String keyId,
  // }) {
  //   /// create payment options
  //   /// you can modify as per your requirements.
  //   /// Ref: https://razorpay.com/docs/payments/server-integration/nodejs/payment-gateway/build-integration/#code-to-add-pay-button
  //   final Map<String, dynamic> options = {
  //     "key": keyId,
  //     "amount": amount,
  //     "currency": "INR",
  //     "order_id": orderId,
  //     "timeout": "240",
  //     "name": "Adtip",
  //     "description": "Watch to Earn",
  //     'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
  //     "readonly": {"contact": true, "email": true},
  //     "send_sms_hash": true,
  //     "remember_customer": false,
  //     "retry": {"enabled": false},
  //     "hidden": {"contact": false, "email": false}
  //   };
  //
  //   /// config razorpay payment methods.
  //   /// This is a "optional" step if you want
  //   /// to customize your payment methods then use this step "options["config"]",
  //   /// otherwise you can skip this step .
  //   /// You can also modify as per your requirements.
  //   /// Ref: https://razorpay.com/docs/api/payments/payment-links/customise-payment-methods/
  //   options["config"] = {
  //     "display": {
  //       "blocks": {
  //         "utib": {
  //           "name": "Pay using Axis Bank",
  //           "instruments": [
  //             {
  //               "method": "card",
  //               "issuers": ["UTIB"]
  //             },
  //             {
  //               "method": "netbanking",
  //               "banks": ["UTIB"]
  //             }
  //           ]
  //         },
  //         "other": {
  //           "name": "Other Payment modes",
  //           "instruments": [
  //             {"method": "card"},
  //             {"method": "netbanking"},
  //             {"method": "wallet"}
  //           ]
  //         }
  //       },
  //       "hide": [
  //         {
  //           "method": "upi",
  //         },
  //         {"method": "emi"}
  //       ],
  //       "sequence": ["block.utib", "block.other"],
  //       "preferences": {"show_default_blocks": false}
  //     }
  //   };
  //   _razorpay.open(options);
  // }

  Future<void> initiatePayment(
      {required Map<String, dynamic> paymentData, required String name}) async {
    // String apiUrl = 'https://api.razorpay.com/v1/orders';
    // // Make the API request to create an order
    // http.Response response = await http.post(
    //   Uri.parse(apiUrl),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Basic ${base64Encode(
    //       utf8.encode(
    //           '${AppConstent.apiKeyRozer}:${AppConstent.apiSecretRozer}'),
    //     )}',
    //   },
    //   body: jsonEncode(paymentData),
    // );
    //
    // if (response.statusCode == 200) {
    //   // Parse the response to get the order ID
    //   var responseData = jsonDecode(response.body);
    //   String orderId = responseData['id'];
    //
    //   // Set up the payment options
    //   var options = {
    //     'key': AppConstent.apiKeyRozer,
    //     'amount': paymentData['amount'],
    //     'name': name,
    //     'order_id': orderId,
    //     'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
    //     'external': {
    //       'wallets': ['paytm'] // optional, for adding support for wallets
    //     }
    //   };
    //
    //   // Open the Razorpay payment form
    //   _razorpay.open(options);
    // } else {
    //   // Handle error response
    //   debugPrint('Error creating order: ${response.body}');
    // }

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
