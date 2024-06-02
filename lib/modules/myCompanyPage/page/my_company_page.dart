import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../helpers/constants/colors.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../helpers/utils/utils.dart';
import '../../../widgets/text/c_title_text.dart';
import '../../ad_model/page/graph/leadscreen.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/my_company_controller.dart';
import '../controller/post_controller.dart';
import '../view_product_details/view_product_detail_controller.dart';
import '../view_product_details/view_product_details.dart';
import '../widgets/c_Text_and_button.dart';
import '../widgets/c_border_button.dart';
import 'add_post_page.dart';
import 'add_product_page.dart';
import 'edit_company_page.dart';
import 'view_post/view_page.dart';
import '../view_product/view_product.dart';

class MyCompanyPage extends StatefulWidget {
  const MyCompanyPage({
    super.key,
  });

  @override
  State<MyCompanyPage> createState() => _MyCompanyPageState();
}

class _MyCompanyPageState extends State<MyCompanyPage> {
  int userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

  int activeindex = 0;
  CompanyDetail? companyData;
  final controller = Get.put(MyCompanyController());
  final companyController = Get.put(CreateCompanyController());
  final dashboardController = Get.put(DashboardController());

  final PostController postController = Get.put(PostController());

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    controller.fetchSingleCompany(
        companyId: companyController.selectedCompanyId.value.toString());
    controller.fetchCompanyProductList(
        companyController.selectedCompanyId.value.toString());

    postController.getPostList(
        companyId: int.tryParse(
            companyController.selectedCompanyId.value.toString())!);
  }

  bool qrShow = false;

  ScreenshotController screenshotController = ScreenshotController();
  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Obx(() {
          if (controller.companyDetailsFetching.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.company.value == null) {
            return const Center(
              child: Text('Company not found'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    if (controller.company.value!.coverImage == null)
                      Container(
                        width: Get.width,
                        height: 205,
                        color: Colors.grey,
                      )
                    else
                      Image.network(
                        controller.company.value!.coverImage!,
                        height: 205,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    Positioned.fill(
                        bottom: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                controller.company.value!.profileImage!),
                          ),
                        ))
                  ],
                ),
                profileDetails(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AdtipColors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, -3.0),
                            blurRadius: 25,
                            spreadRadius: 0,
                            color: AdtipColors.black.withOpacity(0.2))
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      if (userId == controller.company.value!.createdby)
                        CTextAndButton(
                            title: "Top Product",
                            buttonName: 'Add Product',
                            onTap: () {
                              dashboardController.changeWidget(value: 7);
                            })
                      else
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Products',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      const SizedBox(height: 20),
                      controller.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SizedBox(
                              height: controller.companyProductList.isEmpty
                                  ? 100
                                  : 220,
                              child: controller.companyProductList.isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "No Products Added",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: AdtipColors.blackDark),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (userId ==
                                            controller.company.value!.createdby)
                                          Text(
                                            'Add new Products to showcase on your Profile.',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AdtipColors.blackDark),
                                          )
                                      ],
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          controller.companyProductList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            productDetailsController
                                                    .selectedProductId.value =
                                                controller
                                                    .companyProductList[index]
                                                    .id!;
                                            controller.changeWidget(18);
                                          },
                                          child: Container(
                                            height: 200,
                                            width: 157,
                                            padding: EdgeInsets.zero,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  controller
                                                              .companyProductList[
                                                                  index]
                                                              .images ==
                                                          ""
                                                      ? SizedBox(
                                                          height: 150,
                                                          child: Image.asset(
                                                              'assets/extra/dummy.png'),
                                                        )
                                                      : Image.network(
                                                          controller
                                                              .companyProductList[
                                                                  index]
                                                              .images!,
                                                          height: 150,
                                                        ),
                                                  ListTile(
                                                    title: Text(
                                                      controller
                                                              .companyProductList[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AdtipColors
                                                                  .kBlackColor3,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10),
                                                    ),
                                                    subtitle: Text(
                                                      "₹ ${controller.companyProductList[index].marketPrice}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AdtipColors
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                      controller.companyProductList.isEmpty
                          ? const Offstage()
                          : CBorderButton(
                              title: 'SEE ALL PRODUCT', onTap: () {}),
                      const SizedBox(height: 25),
                      if (userId == controller.company.value!.createdby)
                        CTextAndButton(
                            title: "Posts",
                            buttonName: 'Add Post',
                            onTap: () {
                              dashboardController.changeWidget(value: 8);
                            })
                      else
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Posts',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        child: Obx(
                          () {
                            if (postController.loadingPost.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (postController.postData.isEmpty) {
                              return const Center(child: Text("No Data Found"));
                            }
                            return ListView.builder(
                              itemCount: postController.postData.length,
                              // > 4
                              // ? 4
                              // : postController.postData.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (postController.postData[index].imagePath!
                                    .contains('mp4')) {
                                  return Container(
                                    width: 232,
                                    padding: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 184,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 5,
                                                      color:
                                                          AdtipColors.darkBlue),
                                                ),
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return VideoDialog(
                                                              videoUrl:
                                                                  postController
                                                                      .postData[
                                                                          index]
                                                                      .imagePath!);
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.play_circle,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (userId ==
                                                  controller
                                                      .company.value!.createdby)
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      await postController
                                                          .deletePost(
                                                              postId:
                                                                  postController
                                                                      .postData[
                                                                          index]
                                                                      .id!);
                                                      await postController.getPostList(
                                                          companyId: int.tryParse(
                                                              companyController
                                                                  .selectedCompanyId
                                                                  .value
                                                                  .toString())!);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            postController
                                                    .postData[index].postName ??
                                                "",
                                            style: GoogleFonts.poppins(
                                                color: AdtipColors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            postController
                                                    .postData[index].website ??
                                                "",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  width: 232,
                                  padding: EdgeInsets.zero,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 184,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          postController
                                                                  .postData[
                                                                      index]
                                                                  .imagePath
                                                                  ?.split(',')
                                                                  .first ??
                                                              ""),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 5,
                                                      color: AdtipColors
                                                          .darkBlue)),
                                            ),
                                            if (userId ==
                                                controller
                                                    .company.value!.createdby)
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: IconButton(
                                                  onPressed: () async {
                                                    await postController
                                                        .deletePost(
                                                            postId:
                                                                postController
                                                                    .postData[
                                                                        index]
                                                                    .id!);
                                                    await postController.getPostList(
                                                        companyId: int.tryParse(
                                                            companyController
                                                                .selectedCompanyId
                                                                .value
                                                                .toString())!);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          postController
                                                  .postData[index].postName ??
                                              "",
                                          style: GoogleFonts.poppins(
                                              color: AdtipColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          postController
                                                  .postData[index].website ??
                                              "",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      dashboardController.changeWidget(value: 1);
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
          );
        }),
      ),
    );
  }

  Container profileDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            controller.company.value?.name ?? "",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AdtipColors.bluedGrey),
          ),
          Text(controller.company.value?.industry ?? "",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AdtipColors.textClr)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: AdtipColors.grey[800],
              ),
              const SizedBox(
                width: 5,
              ),
              CSubTitleText(
                  subTitle: '${controller.company.value?.location}',
                  textAlign: TextAlign.start),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          if (userId == controller.company.value!.createdby)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AdtipColors.bluedGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      dashboardController.changeWidget(value: 3);
                    },
                    child: Text(
                      'Edit Page',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AdtipColors.white),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: const Color.fromARGB(255, 0, 52, 94),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10))),
                //     onPressed: () {
                //       Get.to(MyLeadPage(
                //           compaginId: controller.company.value?.id,
                //           compaignName: controller.company.value?.name));
                //     },
                //     child: Text(
                //       'Analytics',
                //       style: GoogleFonts.poppins(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w500,
                //           color: AdtipColors.white),
                //     ),
                //   ),
                // ),
              ],
            ),
        ],
      ),
    );
  }

  Widget rowColumn(
    Widget widget,
    String value,
  ) {
    return Column(
      children: [
        widget,
        Text(
          value,
          style: GoogleFonts.poppins(
              color: AdtipColors.textClr,
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
      ],
    );
  }
}

class VideoDialog extends StatefulWidget {
  final String videoUrl;

  VideoDialog({required this.videoUrl});

  @override
  _VideoDialogState createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the video player controller
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    // Initialize the chewie controller
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      // Other Chewie options can be set here
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the video player and chewie controllers when the widget is disposed
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
