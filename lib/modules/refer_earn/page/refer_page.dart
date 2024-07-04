import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../helpers/utils/utils.dart';
import '../../../widgets/button/c_login_button.dart';
import '../controllers/refer_controller.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({super.key});

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  @override
  void initState() {
    super.initState();
    referController.generateReferalCode();
  }

  ReferController referController = Get.put(ReferController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Obx(() {
        if (referController.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Refer AdTip and Earn Money',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF181D20),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset('assets/images/refer.png'),
                const Text(
                  "Note: If your friends or family book an ad in the AdTip app using your referral, you'll receive a 10% commission.",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        const Text('Total Referral Earnings'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '₹${referController.totalReferalEarnings.toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 27, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        referController.referalCode.value,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text: referController.referalCode.value));
                        Utils.showSuccessMessage('Referral Code copied!');
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 27, vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Copy Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Align(alignment: Alignment.center, child: Text('Or')),
                const SizedBox(height: 10),
                CLoginButton(
                    title: 'Copy Link',
                    buttonColor: Colors.blue,
                    textColor: Colors.white,
                    showImage: false,
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(
                          text:
                              'https://adtip.in/mob/refer/?code=${referController.referalCode.value}'));
                      Utils.showSuccessMessage('Referral Link copied!');
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
