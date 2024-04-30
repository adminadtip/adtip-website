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
  bool isUsernameAlreadyUsed = false;
  String? errorMessage;
  final BehaviorSubject<String> _debounce = BehaviorSubject<String>();
  List<CompanyDetail>? companyList;

  @override
  void initState() {
    super.initState();
    _debounce
        .debounceTime(const Duration(
            milliseconds: 1000)) // Adjust the debounce time as needed
        .listen((String value) {
      // Make your API call here using the value from the text field
      fetchCompaniesList(value);

      setState(() {});
    });
  }

  void fetchCompaniesList(String value) async {
    companyList = await controller.fetchCompanyList(_userId);
    if (companyList != null) {
      var result = companyList!.firstWhere(
          (element) =>
              element.name!.toLowerCase().removeAllWhitespace ==
              value.toLowerCase().removeAllWhitespace,
          orElse: () => CompanyDetail());
      if (result.name != null) {
        isUsernameAlreadyUsed = true;
        errorMessage = 'Company name Already Taken!';
      } else {
        isUsernameAlreadyUsed = false;
        errorMessage = null;
      }
    }
    setState(() {});
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
                                  CTextFormField(
                                    labelText: 'Company Name',
                                    errorMessage: controller.isLoading.value
                                        ? null
                                        : errorMessage,
                                    suffixWidget: controller.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : null,
                                    hintText: "Company name",
                                    keyboardType: TextInputType.multiline,
                                    callBack: (p0) {
                                      setState(() {
                                        companyName = p0;
                                        _debounce.add(p0);
                                      });
                                    },
                                    validatorForm: (p0) {
                                      if (p0!.isEmpty) {
                                        return "Invalid Company Name";
                                      }
                                      return null;
                                    },
                                  ),
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
                                  if (_formKey.currentState!.validate() &&
                                      !isUsernameAlreadyUsed) {
                                    controller.userCompanyProfile.companyEmail =
                                        companyEmail;
                                    controller.userCompanyProfile.companyName =
                                        companyName;
                                    controller.userCompanyProfile.phoneNumber =
                                        phoneNumber;
                                    controller.userCompanyProfile.location =
                                        locationDetails;
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
