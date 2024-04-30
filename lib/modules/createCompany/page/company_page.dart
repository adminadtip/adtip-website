import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../../widgets/text/c_title_text.dart';
import '../controller/create_company_controller.dart';
import 'package:flutter/material.dart';

import '../widget/appbar_widget.dart';
import '../widget/c_textFormField.dart';
import 'company_banner.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  int selectedButtonIndex = 0;
  final controller = Get.put(CreateCompanyController());
  final _formKey = GlobalKey<FormState>();
  String? websiteURL;
  String? description;

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
  void initState() {
    super.initState();
    controller.userCompanyProfile.companyType =
        selectedButtonIndex == 0 ? "Products" : "";
  }

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
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 5,
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
                            const SizedBox(
                              height: 20,
                            ),
                            CTextFormField(
                              labelText: 'Description',
                              hintText: "Company Description",
                              callBack: (p0) {
                                setState(() {
                                  description = p0;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CTextFormField(
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
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Company',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                  color: AdtipColors.darkgrey,
                                  borderRadius: BorderRadius.circular(9)),
                              width: 311,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  companyView(0, "Products"),
                                  companyView(1, "Services"),
                                  companyView(2, "Both"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            nextButton(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
// App bar
//

  Widget companyView(int index, String label) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedButtonIndex = index;
              controller.userCompanyProfile.companyType =
                  selectedButtonIndex == 0 ? "Products" : label;
            });
          },
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
        buttonColor: const Color(0xFF01A4AF),
        textColor: AdtipColors.white,
        showImage: false,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            controller.userCompanyProfile.websiteUrl = websiteURL;
            controller.userCompanyProfile.description = description;
            Get.to(() => const CompanyUploadImage());
          }
        });
  }
}
