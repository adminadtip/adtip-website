import 'dart:io';

import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'package:share_plus/share_plus.dart';

import '../../../helpers/constants/Loader.dart';
import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../../widgets/icon/c_icon_image.dart';
import '../../myCompanyPage/page/edit_company_page.dart';
import '../../myCompanyPage/page/my_company_page.dart';
import '../controller/create_company_controller.dart';
import '../model/companyDetail.dart';
import 'create_company_page.dart';

class YourCompaniesPage extends StatefulWidget {
  const YourCompaniesPage({super.key});
  @override
  State<YourCompaniesPage> createState() => _YourCompaniesPageState();
}

class _YourCompaniesPageState extends State<YourCompaniesPage> {
  final controller = Get.put(CreateCompanyController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
  }

  DashboardController dashBoardController = Get.put(DashboardController());
  ScreenshotController screenshotController = ScreenshotController();

  bool qrShow = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.fetchingCompany.value
          ? const SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator())
          : SizedBox(
              width: 500,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      listView(),
                      const SizedBox(
                        height: 20,
                      ),
                      addCompanyButton(),
                    ],
                  ),
                ),
              ),
            );
    });
  }

//
// App bar
//

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Your Companies',
        style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AdtipColors.black),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: CIconImage(
            image: AdtipAssets.SUPPORT_AGENT_ICON,
          ),
        )
      ],
    );
  }

  StatelessWidget listView() {
    return controller.fetchedCompanyList.isEmpty
        ? const Loader()
        : ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.fetchedCompanyList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final companyData = controller.fetchedCompanyList[index];
              return Stack(
                children: [
                  if (qrShow)
                    Center(
                        child: Screenshot(
                            controller: screenshotController,
                            child: ColoredBox(
                              color: Colors
                                  .white, // this color for white backgroud color for screenShot

                              child: Obx(
                                () => QrImageView(data: '', size: 100),
                              ),
                            ))),
                  Theme(
                    data: ThemeData(cardColor: AdtipColors.white),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: companyData.profileImage != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            companyData.profileImage!),
                                      )
                                    // ImageItem(
                                    //         url: companyData.profileImage ?? "",
                                    //         fit: BoxFit.cover,
                                    //       )
                                    : Image.asset('assets/images/asset1.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    companyData.name!,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: AdtipColors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    companyData.industry!,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AdtipColors.grey),
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const Divider(
                                  thickness: 0.3,
                                  color: AdtipColors.grey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        controller.changeCompanyIndex(
                                            index: index,
                                            companyId: controller
                                                .fetchedCompanyList[index].id!);
                                        dashboardController.changeWidget(
                                            value: 2);
                                      },
                                      child: Text(
                                        'View page',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: AdtipColors.lightBlue),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.changeCompanyIndex(
                                            index: index,
                                            companyId: controller
                                                .fetchedCompanyList[index].id!);
                                        dashboardController.changeWidget(
                                            value: 3);
                                      },
                                      child: Text(
                                        'Edit',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: AdtipColors.grey6666),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // print('company id ${controller
                                        //     .fetchedCompanyList[index].id!}');
                                        // controller.fetchedCompanyList
                                        //     .removeWhere((element) =>
                                        //         element.id ==
                                        //         controller
                                        //             .fetchedCompanyList[index]
                                        //             .id!);
                                        controller.deleteCompany(
                                            companyId: controller
                                                .fetchedCompanyList[index].id!);
                                        controller.fetchCompanyList();
                                      },
                                      child: Text(
                                        'Delete',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: AdtipColors.grey6666),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
  }

  Padding addCompanyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: CLoginButton(
          title: 'Add Company Page',
          buttonColor: AdtipColors.black,
          textColor: AdtipColors.white,
          showImage: false,
          onTap: () {
            Get.to(() => const CreateCompanyPage());
          }),
    );
  }
}
