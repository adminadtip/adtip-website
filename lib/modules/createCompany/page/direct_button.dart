import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../controller/create_company_controller.dart';
import '../widget/appbar_widget.dart';
import 'add_button_page.dart';

class DirectButtonPage extends StatefulWidget {
  const DirectButtonPage({super.key});

  @override
  State<DirectButtonPage> createState() => _DirectButtonPageState();
}

class _DirectButtonPageState extends State<DirectButtonPage> {
  bool isChecked = false;
  final controller = Get.put(CreateCompanyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/images/backdrop.png',
              )),
        ),
        child: Center(
          child: SizedBox(
            height: 711,
            width: 472,
            child: Column(
              children: [
                Image.asset('assets/images/adtip_icon.png'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create Company Page',
                        style: GoogleFonts.inter(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Make your Company/Business visible to the users. The best advertising platform.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const AddButtonPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffE4EAFF)),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AdtipAssets.PERSON_BLUE_ICON,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.buttonSelected.value != ""
                                          ? controller.buttonSelected.value
                                          : "Add Button",
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey.shade400),
                                    ),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffE4EAFF)),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Show on profile",
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade400),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => Container(
                          margin: const EdgeInsets.all(15),
                          child: CLoginButton(
                              title: 'Create',
                              buttonColor: const Color(0xFF01A4AF),
                              textColor: AdtipColors.white,
                              showImage: false,
                              isLoading: controller.isLoading.value,
                              onTap: () {
                                if (controller.buttonSelected.value == "") {
                                  Utils.showErrorMessage('Select Add Button');
                                } else {
                                  print("## call:");
                                  controller.createNewCompany();
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
