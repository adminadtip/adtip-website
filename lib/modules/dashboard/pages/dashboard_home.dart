import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ad_model/controllers/ad_models_controller.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../myCompanyPage/controller/post_controller.dart';
import '../../myCompanyPage/view_product/view_product.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  final controller = Get.put(CreateCompanyController());
  final dashboardController = Get.put(DashboardController());
  final adModelsController = Get.put(AdModelsController());
  final PostController postController = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardController.getAllPostsByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.fetchedCompanyList.isEmpty) {
        return const CircularProgressIndicator();
      }
      return Center(
        child: SizedBox(
          width: 500,
          height: Get.height,
          child: Column(
            children: [
              SizedBox(
                height: 140,
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(controller
                                  .fetchedCompanyList[0].profileImage!),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Start your advertising journey today!  🚀',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: const Color(0xFF666666),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFD2F0FF),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  dashboardController.changeWidget(value: 8);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.image,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Post',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: const Color(0xFF666666)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  dashboardController.changeWidget(value: 7);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopping_bag,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Product',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: const Color(0xFF666666)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  dashboardController.changeWidget(value: 11);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.ads_click_sharp,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Advertise',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: const Color(0xFF666666)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: ViewProductScreen()),
              Obx(
                () => dashboardController.postData.isEmpty
                    ? const SizedBox()
                    : Expanded(
                        child: ListView.builder(
                            itemCount: dashboardController.postData.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 450,
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dashboardController
                                                  .postData[index].postName ??
                                              '',
                                          style:
                                              GoogleFonts.roboto(fontSize: 14),
                                        ),
                                        PopupMenuButton<String>(
                                          icon: const Icon(Icons.more_vert),
                                          onSelected: (String result) {
                                            // Handle menu item selection
                                            switch (result) {
                                              case 'Promote':
                                                adModelsController
                                                        .promoteLink.value =
                                                    'https://adtip.in/mob/Post?postId=${dashboardController.postData[index].id}';
                                                dashboardController
                                                    .changeWidget(value: 11);
                                                break;
                                              case 'Delete':
                                                Utils.showAlertDialogYesNo(
                                                    context: context,
                                                    title:
                                                        'Do you want to delete this post?',
                                                    function: () async {
                                                      await postController
                                                          .deletePost(
                                                              postId:
                                                                  dashboardController
                                                                      .postData[
                                                                          index]
                                                                      .id!);
                                                      await dashboardController
                                                          .getAllPostsByUserId();
                                                    },
                                                    subtitle: '');
                                                break;
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'Promote',
                                              child: Text('Promote'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'Delete',
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      child: Image.network(
                                        dashboardController
                                                .postData[index].imagePath ??
                                            '',
                                        height: 307,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })),
              ),
            ],
          ),
        ),
      );
    });
  }
}
