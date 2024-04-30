import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  LoginController loginController = Get.put(LoginController());
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/login.png',
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
                  'Log In',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Welcome back to our revolutionary platform',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF8D8D8D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 200,
                  // height: 200,
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text('Phone Number'),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () async {
                            await loginController.sendOTP(
                                mobileNumber: mobileController.text);
                          },
                          child: const Text(
                            'Sent OTP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
