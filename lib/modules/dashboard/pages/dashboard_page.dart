import 'package:adtip_web_3/helpers/constants/string_constants.dart';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/createCompany/page/your_companies_page.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:adtip_web_3/modules/dashboard/pages/privacy_page.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../../helpers/constants/Loader.dart';

import '../../ad_model/controllers/ad_models_controller.dart';
import '../../authentication/controllers/login_controller.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../createCompany/page/create_company_page.dart';
import 'faq_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardController dashboardController = Get.put(DashboardController());
  final adModelsController = Get.put(AdModelsController());
  final controller = Get.put(CreateCompanyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      adModelsController.getAdModelsList();
      controller.fetchCompanyList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (dashboardController.selected.value > 0) {
          dashboardController.selected.value = 0;
          return;
        } else {}
      },
      child: Scaffold(body: Obx(() {
        if (controller.fetchingCompany.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.fetchedCompanyList.isEmpty) {
          return const CreateCompanyPage();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        'Adtip',
                        style: GoogleFonts.roboto(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFE0201)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset('assets/images/adtip_icon.png'),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Image.asset('assets/icons/home.png'),
                  //     const SizedBox(
                  //       width: 50,
                  //     ),
                  //     Image.asset('assets/icons/star.png'),
                  //     const SizedBox(
                  //       width: 50,
                  //     ),
                  //     Image.asset('assets/icons/calendar.png'),
                  //     const SizedBox(
                  //       width: 50,
                  //     ),
                  //     Image.asset('assets/icons/notification.png'),
                  //     const SizedBox(
                  //       width: 50,
                  //     ),
                  //     Image.asset('assets/icons/Chat.png'),
                  //     const SizedBox(
                  //       width: 50,
                  //     ),
                  //     Image.asset('assets/icons/Profile.png'),
                  //   ],
                  // ),
                  SizedBox(
                    width: 400,
                    height: 100,
                    child: ListView.builder(
                        itemCount: dashboardController.homeMenusLocation.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Obx(() => InkWell(
                              onTap: () {
                                dashboardController.selectedMenu.value = i;
                                if (i == 0) {
                                  dashboardController.changeWidget(value: 0);
                                } else if (i == 1) {
                                  dashboardController.changeWidget(value: 9);
                                } else if (i == 2) {
                                  Utils.showSuccessMessage(
                                      'Feature under development');
                                  // dashboardController.changeWidget(
                                  //     value: 0);
                                } else if (i == 3) {
                                  Utils.showSuccessMessage(
                                      'Feature under development');

                                  // dashboardController.changeWidget(
                                  //     value: 0);
                                }
                              },
                              child: Image.asset(
                                dashboardController.homeMenusLocation[i],
                                color:
                                    dashboardController.selectedMenu.value == i
                                        ? Colors.blue
                                        : Colors.grey,
                              )));
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),

                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 45,
                  //       width: 1,
                  //       color: Colors.grey,
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     SizedBox(
                  //       height: 44,
                  //       width: 267,
                  //       // child: TextFormField(
                  //       //   decoration: InputDecoration(
                  //       //     hintText: 'Search anything in adtip',
                  //       //     border: OutlineInputBorder(
                  //       //       borderRadius: BorderRadius.circular(20),
                  //       //     ),
                  //       //     hintStyle: GoogleFonts.roboto(
                  //       //       fontSize: 12,
                  //       //     ),
                  //       //     fillColor: const Color(0xFFF6F6F6),
                  //       //     suffixIcon: Container(
                  //       //       height: 44,
                  //       //       width: 61,
                  //       //       decoration: const BoxDecoration(
                  //       //         color: Color(0xFF00ACFF),
                  //       //         borderRadius: BorderRadius.only(
                  //       //           // Top left corner
                  //       //           topRight: Radius.circular(
                  //       //               20.0), // Top right corner
                  //       //
                  //       //           bottomRight: Radius.circular(
                  //       //               20.0), // Bottom right corner
                  //       //         ),
                  //       //       ),
                  //       //       child: Center(
                  //       //         child: Image.asset(
                  //       //             'assets/icons/search.png'),
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const SizedBox();
                        }
                        if (controller.fetchedCompanyList.isEmpty) {
                          return const SizedBox();
                        }
                        return Stack(
                          children: [
                            const SizedBox(
                              height: 120,
                              width: 278,
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 82,
                                width: 278,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(controller
                                        .fetchedCompanyList[0].coverImage!),
                                  ),
                                ),
                              ),
                              //     Container(
                              //   height: 82,
                              //   width: 278,
                              //   decoration: const BoxDecoration(
                              //     color: Colors.grey,
                              //     borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(20),
                              //       topLeft: Radius.circular(20),
                              //     ),
                              //   ),
                              //   child: HtmlImageViewCustom(
                              //     imageUrl: controller
                              //         .fetchedCompanyList[0]
                              //         .coverImage!,
                              //     height: 82,
                              //     width: 278,
                              //   ),
                              // ),
                            ),
                            Positioned(
                              top: 70,
                              child:

                                  // Container(
                                  //   height: 44,
                                  //   width: 44,
                                  //   decoration: const BoxDecoration(
                                  //     color: Colors.grey,
                                  //     borderRadius: BorderRadius.only(
                                  //       topRight: Radius.circular(20),
                                  //       topLeft: Radius.circular(20),
                                  //       bottomLeft: Radius.circular(20),
                                  //       bottomRight: Radius.circular(20),
                                  //     ),
                                  //   ),
                                  //   child: HtmlImageViewCustom(
                                  //     imageUrl: controller
                                  //         .fetchedCompanyList[0]
                                  //         .profileImage!,
                                  //     height: 82,
                                  //     width: 278,
                                  //   ),
                                  // ),

                                  Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(18),
                                    topLeft: Radius.circular(18),
                                    bottomLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18),
                                  ),
                                  color: Colors.black,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(controller
                                        .fetchedCompanyList[0].profileImage!),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 85,
                              left: 60,
                              child: Text(
                                controller.fetchedCompanyList[0].name!,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 60,
                              child: Text(
                                controller.fetchedCompanyList[0].about!,
                                style: GoogleFonts.roboto(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            )
                          ],
                        );
                      }),

                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 278,
                        height: 1,
                        color: const Color(0xFFF6F6F6),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const CreateCompanyPage());
                        },
                        child: Row(
                          children: [
                            Image.asset('assets/icons/Plus.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Create new company page',
                              style: GoogleFonts.roboto(
                                  fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFFFCFDFD),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                // Get.to(YourCompaniesPage());
                                dashboardController.changeWidget(value: 1);
                              },
                              child: Text(
                                'My Company',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                // Get.to(const OrderListScreen());
                                dashboardController.changeWidget(value: 9);
                              },
                              child: Text(
                                'Ad Orders',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Utils.showSuccessMessage(
                                    'This feature is under development');
                              },
                              child: Text(
                                'Ad Cart',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Utils.showSuccessMessage(
                                    'This feature is under development');
                              },
                              child: Text(
                                'Wallet',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Utils.showSuccessMessage(
                                    'This feature is under development');
                              },
                              child: Text(
                                'Passbook',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                dashboardController.changeWidget(value: 19);
                              },
                              child: Text(
                                'Refer and Earn',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 278,
                        child: ListTile(
                          title: Text(
                            'AD MODELS FOR YOU',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Creative ways to promote',
                            style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // trailing: OutlinedButton(
                          //   style: ButtonStyle(
                          //     side: MaterialStateProperty.all(
                          //         const BorderSide(
                          //             color: Color(
                          //                 0xFFEB2949))), // Set the border color
                          //   ),
                          //   onPressed: () {
                          //     dashboardController.changeWidget(
                          //         value: 11);
                          //   },
                          //   child: Text(
                          //     'View All',
                          //     style: GoogleFonts.roboto(
                          //         fontSize: 12,
                          //         color: const Color(0xFFEB2949)),
                          //   ),
                          // ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () {
                          if (adModelsController.loading.value) {
                            return const Loader();
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        adModelsController.adModelData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return ad_widget(
                                          imagePath: adModelsController
                                              .adModelData[i].modelImage
                                              .toString(),
                                          title: adModelsController
                                              .adModelData[i].name!,
                                          subtitle:
                                              'Price: ₹${adModelsController.adModelData[i].viewPrice}',
                                          function: () {
                                            adModelsController.setForSkipVideo(
                                                title1: adModelsController
                                                        .adModelData[i].name ??
                                                    "",
                                                viewPrice1: adModelsController
                                                    .adModelData[i].viewPrice,
                                                modelId1: adModelsController
                                                    .adModelData[i].id
                                                    .toString(),
                                                mediaType1: adModelsController
                                                        .adModelData[i]
                                                        .mediaType ??
                                                    '',
                                                link1: '');
                                            dashboardController.changeWidget(
                                                value: 12);
                                          });
                                    }),
                              ),
                            ],
                          );
                        },
                      ),
                      // ad_widget(
                      //   imagePath: 'assets/icons/skip_ad.png',
                      //   title: 'Skip Ad Model',
                      //   subtitle: 'In between Ads',
                      //   function: () {},
                      // ),
                      // ad_widget(
                      //   imagePath: 'assets/icons/master_ad.png',
                      //   title: 'Skip Ad Model',
                      //   subtitle: 'In between Ads',
                      //   function: () {},
                      // ),
                      // ad_widget(
                      //   imagePath: 'assets/icons/qr_code.png',
                      //   title: 'Skip Ad Model',
                      //   subtitle: 'In between Ads',
                      //   function: () {},
                      // ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  //   width: 10,
                  // ),
                  Obx(() => dashboardController
                      .widgets[dashboardController.selected.value]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // InkWell(
                      //     onTap: () {
                      //       dashboardController.changeWidget(value: 11);
                      //     },
                      //     child: Image.asset(
                      //         'assets/images/try_ad_model.png')),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   width: 290,
                      //   height: 65,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     gradient: const LinearGradient(colors: [
                      //       Color(0xFFD8C281),
                      //       Color(0xFFAC9B69),
                      //     ]),
                      //   ),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Adtip Premium',
                      //         style: GoogleFonts.roboto(
                      //             fontSize: 12,
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //       const SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         'Special features only for premium users',
                      //         style: GoogleFonts.roboto(
                      //             fontSize: 10, color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFFFCFDFD),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                dashboardController.changeWidget(value: 9);
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/my_ads.png'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'My Ads',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: const Color(0xFF666666)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                dashboardController.changeWidget(value: 0);
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/my_products.png'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'My Products',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: const Color(0xFF666666)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                Utils.showDialogDemoVideo(
                                    context: context,
                                    videoLink: StringConstants.bookAdDemo);
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.help),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Learn How to Book Ad',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                await dashboardController.logOutUser();
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/manage_admins.png'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Logout',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: const Color(0xFF666666)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ElTooltip(
                              content: SelectableText(
                                  'Call us on 81481471712, we are available 24/7'),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Help',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                Utils.launchWeb(
                                    uri: Uri.parse(StringConstants.whatsapp));
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.webhook),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'WhatsApp',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 215,
                width: Get.width,
                color: const Color(0xFFF7F9FB),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Adtip',
                              style: GoogleFonts.roboto(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFE0201)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset('assets/images/adtip_icon.png'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Navigation',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'About',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Career',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Advertising',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Small Business',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const FaqPage());
                              },
                              child: Text(
                                'FAQ',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Marketing Solutions',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Sales Business',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Help',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SelectableText(
                                  '+91 81481471712',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Community Guidelines',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const PrivacyPolicyText());
                              },
                              child: Text(
                                'Privacy & Terms',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   'Mobile App',
                            //   style: GoogleFonts.roboto(
                            //     fontSize: 12,
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Get our app now:',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Utils.launchWeb(
                                    uri: Uri.parse(
                                        'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app&hl=en_IN&gl=US'));
                              },
                              child: Image.asset(
                                'assets/images/googleplay_icon.png',
                                height: 47,
                                width: 163,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      })),
    );
  }
}

class ad_widget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback function;
  const ad_widget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 275,
          height: 40,
          child: ListTile(
            leading: Image.network(imagePath),
            title: Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 14, color: const Color(0xFF0A0A0A)),
            ),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.inter(
                  fontSize: 14, color: const Color(0xFF9F9BB9)),
            ),
            trailing: InkWell(
              onTap: function,
              child: Text(
                'Book',
                style: GoogleFonts.inter(
                    fontSize: 12, color: const Color(0xFF00ACFF)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 0.5,
          width: 275,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
