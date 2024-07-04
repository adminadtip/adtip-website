import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../../widgets/text/c_title_text.dart';
import '../controller/create_company_controller.dart';
import '../model/companyDetail.dart';
import '../widget/appbar_widget.dart';
import '../widget/c_textFormField.dart';
import 'company_page.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({super.key});

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final controller = Get.put(CreateCompanyController());
  get _userId => LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);

  String companyName = "";
  String companyEmail = "";
  String phoneNumber = "";
  String locationDetails = "";
  RegExp regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();

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
                              height: 30,
                            ),
                            Text(
                              'Create Company Page',
                              style: GoogleFonts.inter(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Make your Company/Business visible to the users. The best advertising platform.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(fontSize: 12),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() => CTextFormField(
                                        labelText: 'Company Name',
                                        errorMessage: controller
                                                .isCheckingCompanyName.value
                                            ? null
                                            : controller
                                                .errorMessageForCompanyExist
                                                .value,
                                        suffixWidget: controller
                                                .isCheckingCompanyName.value
                                            ? const CircularProgressIndicator()
                                            : null,
                                        hintText: "Company name",
                                        keyboardType: TextInputType.multiline,
                                        callBack: (p0) {
                                          companyName = p0;
                                        },
                                        validatorForm: (p0) {
                                          if (p0!.isEmpty) {
                                            return "Invalid Company Name";
                                          }
                                          return null;
                                        },
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CTextFormField(
                                    labelText: 'Company Email',
                                    hintText: "Company Email",
                                    keyboardType: TextInputType.emailAddress,
                                    callBack: (p0) {
                                      setState(() {
                                        companyEmail = p0;
                                      });
                                    },
                                    validatorForm: (p0) {
                                      if (!regExp.hasMatch(p0 ?? "")) {
                                        return "Invalid Email Address";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CTextFormField(
                                    labelText: 'Phone Number',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp('^[0-9]{1,10}'),
                                      ),
                                    ],
                                    hintText: "Company Number",
                                    keyboardType: TextInputType.phone,
                                    callBack: (p0) {
                                      setState(() {
                                        phoneNumber = p0;
                                      });
                                    },
                                    validatorForm: (p0) {
                                      if (p0!.length != 10) {
                                        return 'Invalid Phone Number';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CTextFormField(
                                    labelText: 'Company Location',
                                    hintText: "Enter Location",
                                    keyboardType: TextInputType.multiline,
                                    callBack: (p0) {
                                      setState(() {
                                        locationDetails = p0;
                                      });
                                    },
                                    validatorForm: (p0) {
                                      if (p0!.length < 3) {
                                        return "Invalid Location";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CLoginButton(
                                title: 'Create',
                                buttonColor: const Color(0xFF01A4AF),
                                textColor: AdtipColors.white,
                                showImage: false,
                                onTap: () {
                                  print(
                                      'company name exist ${controller.isCompanyNameAlreadyUsed.value}');
                                  if (_formKey.currentState!.validate()) {
                                    controller.userCompanyProfile.companyEmail =
                                        companyEmail;
                                    controller.userCompanyProfile.companyName =
                                        companyName;
                                    controller.userCompanyProfile.phoneNumber =
                                        phoneNumber;
                                    controller.userCompanyProfile.location =
                                        locationDetails;
                                    print('company name $companyName');
                                    Get.to(() => const CompanyPage());
                                  }
                                }),
                            const SizedBox(
                              height: 30,
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
}
