import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helpers/constants/asset_files.dart';
import '../../../../helpers/constants/colors.dart';
import '../../../createCompany/controller/imageItem.dart';

import '../../../dashboard/controller/dashboard_controller.dart';
import '../../controller/my_company_controller.dart';
import '../../controller/post_controller.dart';

class ViewPost extends StatefulWidget {
  final String companyName;
  final String image;

  const ViewPost({super.key, required this.companyName, required this.image});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final PostController postController = Get.put(PostController());

  DashboardController dashBoardController = Get.put(DashboardController());
  final companyController = Get.put(MyCompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(),
        body: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: postController.postData.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AdtipColors.white,
                    child: ListTile(
                      minLeadingWidth: 0,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ImageItem(
                          showCircleAvatar: true,
                          url: widget.image,
                          showDummyImage: true,
                          dummyImagePath: "",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        postController.postData[index].postName ?? "",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AdtipColors.black),
                      ),
                      subtitle: Row(
                        children: [
                          Text(postController.postData[index].website ?? "",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AdtipColors.grey)),
                          Image.asset(AdtipAssets.ARROW_UP,
                              height: 15, width: 15)
                        ],
                      ),
                      // trailing: Container(
                      //   padding: const EdgeInsets.all(6),
                      //   decoration: ShapeDecoration(
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(width: 1),
                      //       borderRadius: BorderRadius.circular(4),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'Promote',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       color: Color(0xFF292A2E),
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: postController.postData[index].imagePath
                        ?.split(',')
                        .length,
                    itemBuilder: (context, i, realIndex) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(postController
                                    .postData[index].imagePath
                                    ?.split(',')[i] ??
                                ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 270,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.95,
                    ),
                  ),

                  // Text(
                  //   'Earn money',
                  //   textAlign: TextAlign.left,
                  //   style: TextStyle(
                  //     color: Color(0xFFB55B52),
                  //     fontSize: 14,
                  //     fontFamily: 'Lato',
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 12, vertical: 8),
                  //         decoration: ShapeDecoration(
                  //           shape: RoundedRectangleBorder(
                  //               side: BorderSide(
                  //                   width: 1, color: Color(0xFF181D20)),
                  //               borderRadius: BorderRadius.circular(4)),
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               'Like',
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                 color: Color(0xFF181D20),
                  //                 fontSize: 16.sp,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //             SizedBox(width: 2.w),
                  //             Icon(Icons.thumb_up, size: 15.h)
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 15.w),
                  //     Expanded(
                  //       child: Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 12, vertical: 9),
                  //         decoration: ShapeDecoration(
                  //           color: Color(0xFF181D20),
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(4)),
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             'Buy',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 16.sp,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Container(
                    color: AdtipColors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                          postController.postData[index].postDiscription ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start),
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              );
            }));
  }

  AppBar header() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 40,
        ),
      ),
      centerTitle: true,
      title: Text(
        "Your Posts",
        style: GoogleFonts.poppins(
            color: AdtipColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16),
      ),
    );
  }
}
