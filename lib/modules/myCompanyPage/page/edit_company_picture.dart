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
import 'edit_direct_button_page.dart';

class CompanyEditImage extends StatefulWidget {
  const CompanyEditImage({super.key});

  @override
  State<CompanyEditImage> createState() => _CompanyEditImageState();
}

class _CompanyEditImageState extends State<CompanyEditImage> {
  EditCompanyController editCompanyController =
      Get.put(EditCompanyController());
  final myCompanyController = Get.put(MyCompanyController());
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
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
                        margin: const EdgeInsets.all(15),
                        child: ClipPath(
                            clipper: DiagonalClipper(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: editCompanyController.coverImage.value == ''
                                ? myCompanyController
                                            .company.value?.coverImage ==
                                        null
                                    ? Image.asset(
                                        AdtipAssets.COMPANY_BANNER_IMAGE,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        myCompanyController
                                            .company.value!.coverImage!,
                                        fit: BoxFit.cover,
                                      )
                                : Image.network(
                                    editCompanyController.coverImage.value,
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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(15),
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
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CLoginButton(
                      title: 'Next',
                      isLoading: false,
                      buttonColor: AdtipColors.black,
                      textColor: AdtipColors.white,
                      showImage: false,
                      onTap: () {
                        dashboardController.changeWidget(value: 6);
                        // if (editCompanyController.imageBanner!.value.path !=
                        //             '' &&
                        //         editCompanyController
                        //                 .imageCompanyProfile!.value.path !=
                        //             '' ||
                        //     myCompanyController.company.value?.coverImage !=
                        //             null &&
                        //         myCompanyController
                        //                 .company.value?.profileFilename !=
                        //             null) {
                        //
                        // } else {
                        //   Utils.showErrorMessage('Please select image');
                        // }
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      dashboardController.changeWidget(value: 4);
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
                        backgroundImage:
                            editCompanyController.profileImage.value ==
                                    ''
                                ? (myCompanyController
                                            .company.value?.profileImage ==
                                        null
                                    ? const AssetImage(
                                        AdtipAssets.COMPANY_PROFILE_IMAGE)
                                    : const AssetImage(
                                            AdtipAssets.COMPANY_PROFILE_IMAGE)
                                        as ImageProvider<Object>?)
                                : NetworkImage(
                                    editCompanyController.profileImage.value),
                        child: editCompanyController.profileImage.value == ''
                            ? (myCompanyController
                                        .company.value?.profileImage ==
                                    null
                                ? const Offstage()
                                : CircleAvatar(
                                    radius: 70.0,
                                    backgroundImage: NetworkImage(
                                      myCompanyController
                                          .company.value!.profileImage!,
                                    ),
                                  ))
                            : const Offstage()),
                  ),
                  const SizedBox(
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
