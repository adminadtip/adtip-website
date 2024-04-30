import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../controller/create_company_controller.dart';
import '../widget/appbar_widget.dart';
import 'direct_button.dart';

class CompanyUploadImage extends StatefulWidget {
  const CompanyUploadImage({super.key});

  @override
  State<CompanyUploadImage> createState() => _CompanyUploadImageState();
}

class _CompanyUploadImageState extends State<CompanyUploadImage> {
  CreateCompanyController createCompanyController =
      Get.put(CreateCompanyController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
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
                                      child: createCompanyController
                                                  .coverImage.value ==
                                              ''
                                          ? Image.asset(
                                              AdtipAssets.COMPANY_BANNER_IMAGE,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              createCompanyController
                                                  .coverImage.value,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                              ),
                              Positioned(
                                bottom: 260,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () async {
                                    createCompanyController.pickBannerImage();
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
                                    child: Text(
                                      'Upload',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
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
                                buttonColor: const Color(0xFF01A4AF),
                                textColor: Colors.white,
                                showImage: false,
                                onTap: () {
                                  if (createCompanyController
                                              .coverImage.value !=
                                          '' &&
                                      createCompanyController
                                              .profileImage.value !=
                                          '') {
                                    Get.to(() => const DirectButtonPage());
                                  } else {
                                    Utils.showErrorMessage(
                                        'Please Select Image');
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 30,
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
                                radius: 70,
                                backgroundImage: createCompanyController
                                            .profileImage.value ==
                                        ''
                                    ? const AssetImage(
                                        AdtipAssets.COMPANY_PROFILE_IMAGE,
                                      ) as ImageProvider<Object>?
                                    : NetworkImage(
                                        createCompanyController
                                            .profileImage.value,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                createCompanyController
                                    .pickCompanyProfileImage();
                              },
                              child: Text(
                                'Upload',
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
              ],
            ),
          ),
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
