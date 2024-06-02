import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("SUCCESS!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Image.asset(
              'assets/images/success.png',
              fit: BoxFit.cover,
              height: 250,
            ),
            const Text(
                "Your ad order will be live soon.\nThank you for choosing AdTip!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 30),
            CLoginButton(
              title: 'Track your orders',
              onTap: () {
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (context) => OrderListScreen()),
                //     (Route<dynamic> route) => false);
                // Get.offAll(const OrderListScreen());
                dashboardController.changeWidget(value: 9);
              },
              buttonColor: AdtipColors.black,
              textColor: AdtipColors.white,
              showImage: false,
            ),
            const SizedBox(height: 10),
            CLoginButton(
              title: 'BACK TO AD MODELS',
              onTap: () {
                dashboardController.changeWidget(value: 0);
              },
              buttonColor: AdtipColors.white,
              textColor: AdtipColors.black,
              showImage: false,
            )
          ],
        ),
      ),
    );
  }
}
