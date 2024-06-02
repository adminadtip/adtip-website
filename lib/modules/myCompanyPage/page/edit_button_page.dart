import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/widget/appbar_widget.dart';
import '../controller/edit_company_controller.dart';
import '../controller/my_company_controller.dart';

class EditButtonPage extends StatefulWidget {
  const EditButtonPage({super.key});

  @override
  State<EditButtonPage> createState() => _EditButtonPageState();
}

class _EditButtonPageState extends State<EditButtonPage> {
  late int selectedRadio;
  final dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  void setSelectedRadio(int? val) {
    setState(() {
      selectedRadio = val ?? 0;
    });
  }

  List<String> radioButtonList = [
    "Book Now",
    "Visit Page",
    "Know More",
    "Buy Now",
    "Reserve"
  ];

  final controller = Get.put(EditCompanyController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Select Button',
              style:
                  GoogleFonts.inter(fontSize: 27, fontWeight: FontWeight.w500),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: Text(
                'Fill the information to use the exclusive features in advertiser panel',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: radioButtonList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffE4EAFF)),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          radioButtonList[index],
                          style:
                              GoogleFonts.roboto(color: Colors.grey.shade400),
                        ),
                        Radio(
                          value: index + 1,
                          groupValue: selectedRadio,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio(val);
                          },
                        ),
                      ],
                    ),
                  );
                }),
            Container(
              margin: const EdgeInsets.all(15),
              child: CLoginButton(
                  title: 'Save',
                  buttonColor: AdtipColors.black,
                  textColor: AdtipColors.white,
                  showImage: false,
                  isLoading: false,
                  onTap: () {
                    /* Get.to(()=>const CompanyPage()); */
                    controller.buttonSelected.value =
                        radioButtonList[selectedRadio - 1];
                    controller.userCompanyProfile.buttonType =
                        radioButtonList[selectedRadio - 1];
                    controller.update();
                    dashboardController.changeWidget(value: 6);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  dashboardController.changeWidget(value: 6);
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
