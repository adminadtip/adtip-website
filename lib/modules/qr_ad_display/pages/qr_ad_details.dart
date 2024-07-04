import 'package:adtip_web_3/helpers/constants/string_constants.dart';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/authentication/controllers/login_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/qr_ad_controller.dart';

class QrAddDetails extends StatefulWidget {
  final int companyId;
  final int adId;
  final String companyName;
  const QrAddDetails(
      {super.key,
      required this.companyId,
      required this.adId,
      required this.companyName});

  @override
  State<QrAddDetails> createState() => _QrAddDetailsState();
}

class _QrAddDetailsState extends State<QrAddDetails> {
  final qrController = Get.put(QrCodeAdDisplayController());

  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();

  bool mobileNumberEnteredValid = false;
  bool otpValid = false;
  bool otpSent = false;
  bool otpVerified = false;
  final nameController = TextEditingController();
  final upiController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String selectedProfession = "Select your profession";

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    } else if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number must contain only digits';
    }
    return null;
  }

  Future<Future> selectedProfessionDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              width: 400,
              child: AlertDialog(
                backgroundColor: Colors.white,
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: StringConstants.profession.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                selectedProfession =
                                    StringConstants.profession[index];

                                Navigator.pop(
                                  context,
                                );
                                setState(() {});
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  StringConstants.profession[index],
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 400,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Adtip',
                              style: GoogleFonts.roboto(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFE0201)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset('assets/images/adtip_icon.png'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'You earned ₹3, enter details to get the money.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 220,
                            child: TextFormField(
                              controller: mobileNumberController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateMobileNumber,
                              onChanged: (value) {
                                if (value.isNotEmpty && value.length == 10) {
                                  setState(() {
                                    mobileNumberEnteredValid = true;
                                  });
                                } else {
                                  setState(() {
                                    mobileNumberEnteredValid = false;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          !mobileNumberEnteredValid
                              ? const SizedBox()
                              : Obx(() => qrController.sendOtp.value
                                  ? const CircularProgressIndicator()
                                  : InkWell(
                                      onTap: () async {
                                        await qrController.sendOTP(
                                            mobileNumber: mobileNumberController
                                                .text
                                                .trim());
                                        setState(() {
                                          otpSent = true;
                                        });
                                      },
                                      child: const Text(
                                        'Send OTP',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 12),
                                      )))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !otpSent
                        ? const SizedBox()
                        : SizedBox(
                            height: 50,
                            width: 300,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: TextFormField(
                                    controller: otpController,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6),
                                    ],
                                    decoration: const InputDecoration(
                                      labelText: 'OTP',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty &&
                                          value.length == 6) {
                                        setState(() {
                                          otpValid = true;
                                        });
                                      } else {
                                        setState(() {
                                          otpValid = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                otpVerified
                                    ? const Text(
                                        'Verified',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 12),
                                      )
                                    : !otpValid
                                        ? const SizedBox()
                                        : Obx(
                                            () => qrController.checkOtp.value
                                                ? const CircularProgressIndicator()
                                                : InkWell(
                                                    onTap: () async {
                                                      await qrController
                                                          .verifyOTP(
                                                              otpController.text
                                                                  .trim(),
                                                              qrController
                                                                  .otpId.value);
                                                      setState(() {
                                                        otpVerified = true;
                                                      });
                                                      print(
                                                          'otp verified $otpVerified');
                                                    },
                                                    child: const Text(
                                                      'Verify',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                          ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    !otpVerified
                        ? const SizedBox()
                        : Form(
                            key: formKey,
                            child: SizedBox(
                              width: 220,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: TextFormField(
                                      controller: upiController,
                                      decoration: const InputDecoration(
                                        labelText: 'UPI Id',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your UPI Id';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectedProfessionDialog();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 48,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                selectedProfession,
                                                style: GoogleFonts.inter(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(
                                                  Icons.arrow_drop_down_circle)
                                            ],
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Obx(() => qrController.submittingData.value
                                      ? const CircularProgressIndicator()
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  onPressed: () async {
                                                    if (selectedProfession ==
                                                        'Select your profession') {
                                                      Utils.showErrorMessage(
                                                          'Please select your profession');
                                                      return;
                                                    }
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      formKey.currentState!
                                                          .save();
                                                      try {
                                                        await qrController.submitQrData(
                                                            companyName: widget
                                                                .companyName,
                                                            companyId: widget
                                                                .companyId,
                                                            adId: widget.adId,
                                                            name: nameController
                                                                .text
                                                                .trim(),
                                                            mobile: int.tryParse(
                                                                mobileNumberController
                                                                    .text
                                                                    .trim())!,
                                                            upiId: upiController
                                                                .text
                                                                .trim(),
                                                            profession:
                                                                selectedProfession);
                                                        nameController.text =
                                                            '';
                                                        upiController.text = '';
                                                        otpVerified = false;
                                                        otpController.text = '';
                                                        otpSent = false;
                                                        setState(() {});
                                                        if (kDebugMode) {
                                                          print(
                                                              '${widget.companyName} ${widget.companyId} ${nameController.text.trim()} ${int.tryParse(mobileNumberController.text.trim())} ${upiController.text.trim()}');
                                                        }
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                          Utils.launchWeb(
                                                              uri: Uri.parse(
                                                                  'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app&hl=en_IN&gl=US'));
                                                        });
                                                      } catch (e) {
                                                        if (kDebugMode) {
                                                          print('e $e');
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ],
                                        )),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
