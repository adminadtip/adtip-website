import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../helpers/constants/Loader.dart';
import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/widget/appbar_widget.dart';
import '../../createCompany/widget/c_textFormField.dart';
import '../controller/edit_company_controller.dart';
import 'edit_company.dart';

class EditCompanyPage extends StatefulWidget {
  final CompanyDetail companyData;
  const EditCompanyPage({super.key, required this.companyData});

  @override
  State<EditCompanyPage> createState() => _EditCompanyPageState();
}

class _EditCompanyPageState extends State<EditCompanyPage> {
  final controller = Get.put(EditCompanyController());
  final BehaviorSubject<String> _debounce = BehaviorSubject<String>();
  String companyName = "";
  String companyEmail = "";
  String phoneNumber = "";
  String locationDetails = "";
  RegExp regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();
  List<CompanyDetail>? companyList;
  bool isUsernameAlreadyUsed = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _debounce
        .debounceTime(
            Duration(milliseconds: 1000)) // Adjust the debounce time as needed
        .listen((String value) {
      // Make your API call here using the value from the text field
      fetchCompaniesList(value);

      setState(() {});
    });
  }

  void fetchCompaniesList(String value) async {
    companyList = await controller.fetchCompanyList();
    if (companyList != null) {
      var result = companyList!.firstWhere(
          (element) =>
              element.name!.toLowerCase().removeAllWhitespace ==
              value.toLowerCase().removeAllWhitespace,
          orElse: () => CompanyDetail());
      if (result.name != null && result.name != widget.companyData.name) {
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
      backgroundColor: Color(0xffF5F7FF),
      appBar: appBar(
          title: "Edit Company Page",
          showIcon: false,
          textColor: AdtipColors.black),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Edit Company Page',
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CTextFormField(
                          errorMessage:
                              controller.isLoading.value ? null : errorMessage,
                          suffixWidget: controller.isLoading.value
                              ? Loader(
                                  height: 2,
                                )
                              : null,
                          initialValue: widget.companyData.name,
                          hintText: "Company name",
                          keyboardType: TextInputType.multiline,
                          callBack: (p0) {
                            setState(() {
                              companyName = p0;
                              companyName.isNotEmpty ? _debounce.add(p0) : null;
                            });
                          },
                          validatorForm: (p0) {
                            if (p0!.isEmpty) {
                              return "Invalid Company Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CTextFormField(
                          initialValue: widget.companyData.email,
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
                        SizedBox(
                          height: 10,
                        ),
                        CTextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('^[0-9]{1,10}'),
                            ),
                          ],
                          initialValue: widget.companyData.phone == "undefined"
                              ? null
                              : widget.companyData.phone,
                          hintText: "Phone no",
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
                        SizedBox(
                          height: 10,
                        ),
                        CTextFormField(
                          initialValue: widget.companyData.location,
                          hintText: "Location",
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
                  SizedBox(
                    height: 20,
                  ),
                  CLoginButton(
                      title: 'Next',
                      buttonColor: AdtipColors.black,
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
                          Get.to(() => EditCompany(
                                companyData: widget.companyData,
                              ));
                        }
                      }),
                  SizedBox(
                    height: 20,
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
          ),
        ),
      ),
    );
  }
}
