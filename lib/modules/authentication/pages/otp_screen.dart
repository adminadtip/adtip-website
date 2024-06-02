import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../controllers/login_controller.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final int id;
  const OtpScreen({super.key, required this.mobileNumber, required this.id});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  LoginController loginController = Get.put(LoginController());
  final mobileController = TextEditingController();
  TextEditingController controller = TextEditingController();
  String? otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/otp.png',
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            width: 30,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Verify your phone number',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'We’ve sent an SMS with an activation code to your phone\n'
                  '+91${widget.mobileNumber}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF8D8D8D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                otpFiled(),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => loginController.checkOtp.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () async {
                            await loginController.verifyOTP(otp!, widget.id);
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  otpFiled() {
    return Pinput(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      length: 6,
      controller: controller,
      defaultPinTheme: PinTheme(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400)),
      ),
      onCompleted: (pin) async {
        if (pin.length == 6) {
          // loginController.error.value = false;
          otp = pin;
          print("pin:::::::::::::::::${otp}");
        } else {
          //phoneLoginController.error.value = true;
        }
      },
    );
  }
}
