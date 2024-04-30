import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/widget/appbar_widget.dart';
import '../controller/edit_company_controller.dart';
import 'edit_direct_button_page.dart';

class CompanyEditImage extends StatefulWidget {
  final CompanyDetail companyData;
  const CompanyEditImage({super.key, required this.companyData});

  @override
  State<CompanyEditImage> createState() => _CompanyEditImageState();
}

class _CompanyEditImageState extends State<CompanyEditImage> {
  EditCompanyController editCompanyController =
      Get.put(EditCompanyController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF5F7FF),
      appBar: appBar(
          title: "Edit Company Page",
          showIcon: false,
          textColor: AdtipColors.black),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () => Container(
                        height: 300,
                        width: size.width,
                        margin: EdgeInsets.all(15),
                        child: ClipPath(
                            clipper: DiagonalClipper(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: editCompanyController
                                        .imageBanner!.value.path ==
                                    ''
                                ? widget.companyData.coverImage == null
                                    ? Image.asset(
                                        AdtipAssets.COMPANY_BANNER_IMAGE,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        widget.companyData.coverImage!,
                                        fit: BoxFit.cover,
                                      )
                                : Image.file(
                                    editCompanyController.imageBanner!.value,
                                    fit: BoxFit.fill,
                                  )),
                      ),
                    ),
                    Positioned(
                      bottom: 260,
                      right: 5,
                      child: GestureDetector(
                        onTap: () async {
                          editCompanyController.pickBannerImage();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(15),
                          width: 75,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              'Edit',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CLoginButton(
                      title: 'Next',
                      isLoading: false,
                      buttonColor: AdtipColors.black,
                      textColor: AdtipColors.white,
                      showImage: false,
                      onTap: () {
                        if (editCompanyController.imageBanner!.value.path !=
                                    '' &&
                                editCompanyController
                                        .imageCompanyProfile!.value.path !=
                                    '' ||
                            widget.companyData.coverImage != null &&
                                widget.companyData.profileFilename != null) {
                          Get.to(() => EditDirectButtonPage(
                                companyData: widget.companyData,
                              ));
                        } else {
                          editCompanyController.showMessage(
                              "Please Select Image",
                              isError: true);
                        }
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Positioned(
              bottom: 200,
              left: 100,
              child: Column(
                children: [
                  Obx(
                    () => CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: editCompanyController
                                    .imageCompanyProfile!.value.path ==
                                ''
                            ? (widget.companyData.profileImage == null
                                ? AssetImage(AdtipAssets.COMPANY_PROFILE_IMAGE)
                                : AssetImage(AdtipAssets.COMPANY_PROFILE_IMAGE)
                                    as ImageProvider<Object>?)
                            : FileImage(editCompanyController
                                .imageCompanyProfile!.value),
                        child: editCompanyController
                                    .imageCompanyProfile!.value.path ==
                                ''
                            ? (widget.companyData.profileImage == null
                                ? Offstage()
                                : CircleAvatar(
                                    radius: 70.0,
                                    backgroundImage: NetworkImage(
                                      widget.companyData.profileImage!,
                                    ),
                                  ))
                            : Offstage()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      editCompanyController.pickCompanyProfileImage();
                    },
                    child: Text(
                      'Edit',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 100;
    Offset controlPoint = Offset(size.width / 3, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
