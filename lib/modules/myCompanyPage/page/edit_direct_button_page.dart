import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/widget/appbar_widget.dart';
import '../controller/edit_company_controller.dart';
import 'edit_button_page.dart';

class EditDirectButtonPage extends StatefulWidget {
  final CompanyDetail companyData;
  const EditDirectButtonPage({super.key, required this.companyData});

  @override
  State<EditDirectButtonPage> createState() => _EditDirectButtonPageState();
}

class _EditDirectButtonPageState extends State<EditDirectButtonPage> {
  bool isChecked = false;
  final controller = Get.put(EditCompanyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FF),
      appBar: appBar(
          title: "Edit Company Page",
          showIcon: false,
          textColor: AdtipColors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => EditButtonPage(
                      companyData: widget.companyData,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE4EAFF)),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AdtipAssets.PERSON_BLUE_ICON,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => Text(
                            controller.buttonSelected.value != ""
                                ? controller.buttonSelected.value
                                : widget.companyData.button != null
                                    ? widget.companyData.button!
                                    : "Add Button",
                            style:
                                GoogleFonts.roboto(color: Colors.grey.shade400),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE4EAFF)),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                margin: EdgeInsets.all(15),
                child: CLoginButton(
                    title: 'Save',
                    buttonColor: AdtipColors.black,
                    textColor: AdtipColors.white,
                    showImage: false,
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (controller.buttonSelected.value == "" &&
                          widget.companyData.button == null) {
                        controller.showMessage("Select Add Button",
                            isError: true);
                      } else {
                        controller.updateCompany(
                            companyId: widget.companyData.id!);
                      }
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Get.back();
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
