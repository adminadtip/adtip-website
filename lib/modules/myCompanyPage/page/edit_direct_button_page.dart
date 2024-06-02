import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/widget/appbar_widget.dart';
import '../controller/edit_company_controller.dart';
import '../controller/my_company_controller.dart';
import 'edit_button_page.dart';

class EditDirectButtonPage extends StatefulWidget {
  const EditDirectButtonPage({super.key});

  @override
  State<EditDirectButtonPage> createState() => _EditDirectButtonPageState();
}

class _EditDirectButtonPageState extends State<EditDirectButtonPage> {
  bool isChecked = false;
  final controller = Get.put(EditCompanyController());
  final myCompanyController = Get.put(MyCompanyController());
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                dashboardController.changeWidget(value: 17);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE4EAFF)),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                                : myCompanyController.company.value!.button !=
                                        null
                                    ? myCompanyController.company.value!.button!
                                    : "Add Button",
                            style:
                                GoogleFonts.roboto(color: Colors.grey.shade400),
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
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Show on profile",
                    style: GoogleFonts.roboto(color: Colors.grey.shade400),
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
                    title: 'Save',
                    buttonColor: AdtipColors.black,
                    textColor: AdtipColors.white,
                    showImage: false,
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (controller.buttonSelected.value == "" &&
                          myCompanyController.company.value!.button == null) {
                        Utils.showErrorMessage('Select Add Button');
                      } else {
                        controller.updateCompany(
                            companyId: myCompanyController.company.value!.id!);
                      }
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  dashboardController.changeWidget(value: 5);
                },
                child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: AdtipColors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'Back',
                      style: GoogleFonts.inter(
                          color: AdtipColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
