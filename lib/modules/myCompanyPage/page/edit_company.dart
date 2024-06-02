import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/widget/appbar_widget.dart';
import '../../createCompany/widget/c_textFormField.dart';
import '../controller/edit_company_controller.dart';
import '../controller/my_company_controller.dart';
import 'edit_company_picture.dart';

class EditCompany extends StatefulWidget {
  const EditCompany({super.key});

  @override
  State<EditCompany> createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  int selectedButtonIndex = 0;
  final controller = Get.put(EditCompanyController());
  final _formKey = GlobalKey<FormState>();
  String? websiteURL;
  String? description;
  final myCompanyController = Get.put(MyCompanyController());
  final dashboardController = Get.put(DashboardController());

  String? hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter url';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid url';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Edit Company Page',
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  descriptione(),
                  const SizedBox(
                    height: 10,
                  ),
                  CTextFormField(
                    initialValue: myCompanyController.company.value!.website,
                    hintText: "Website",
                    keyboardType: TextInputType.multiline,
                    callBack: (p0) {
                      print("p0stinrg valu $p0");
                      websiteURL = p0;
                    },
                    validatorForm: (website) {
                      String pattern =
                          r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                      RegExp regExp = RegExp(pattern);
                      if (website!.isEmpty) {
                        return "Please enter your website";
                      } else if (!(regExp.hasMatch(website))) {
                        return "Website Url must be started from www";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  nextButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        dashboardController.changeWidget(value: 3);
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
          ),
        ),
      ),
    );
  }

//
// App bar
//

  Center descriptione() {
    return Center(
      child: Container(
        height: 110,
        width: 320,
        padding: EdgeInsets.zero,
        child: Theme(
          data: ThemeData(cardColor: AdtipColors.white),
          child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: AdtipColors.darkIndigo,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Image.asset(
                          AdtipAssets.PERSON_BLUE_ICON,
                          height: 20,
                          width: 20,
                        )),
                    const VerticalDivider(
                      endIndent: 80,
                      indent: 10,
                      color: AdtipColors.black,
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: myCompanyController.company.value!.about,
                        onChanged: (val) {
                          description = val;
                        },
                        cursorColor: Colors.black,
                        validator: (p0) {
                          if (p0!.length < 5) {
                            return "Invalid Description ";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            counterStyle: GoogleFonts.poppins(fontSize: 13),
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            hintText: "Description"),
                        keyboardType: TextInputType.multiline,
                        maxLength: 200,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget companyView(int index, String label) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: 95,
            height: 27,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedButtonIndex == index ? AdtipColors.white : null,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selectedButtonIndex == index
                        ? AdtipColors.black
                        : null)),
          ),
        ),
        if ((index == 0 && selectedButtonIndex == 2) ||
            (index == 1 && selectedButtonIndex == 0))
          const VerticalDivider(
            color: Colors.black,
            width: 1.0,
            indent: 7,
            endIndent: 7,
          ),
        const SizedBox(
          width: 4,
        )
      ],
    );
  }

  CLoginButton nextButton() {
    return CLoginButton(
        title: 'Next',
        isLoading: false,
        buttonColor: AdtipColors.black,
        textColor: AdtipColors.white,
        showImage: false,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            controller.userCompanyProfile.websiteUrl = websiteURL;
            controller.userCompanyProfile.description = description;
            dashboardController.changeWidget(value: 5);
          }
        });
  }
}
