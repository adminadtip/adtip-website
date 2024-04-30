import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:readmore/readmore.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/constants/colors.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/my_company_controller.dart';
import '../page/add_product_page.dart';
import '../view_product/view_product_controller.dart';
import 'view_product_detail_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  final String companyID;
  ProductDetailScreen({
    super.key,
    required this.id,
    required this.companyID,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final controller = Get.put(CreateCompanyController());
  int userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;
  List<String> selectedSize = <String>[];
  int activeIndex = 0;
  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  final companyController = Get.put(MyCompanyController());
  final ProductController productController = Get.put(ProductController());
  ScreenshotController screenshotController = ScreenshotController();
  DashboardController dashBoardController = Get.put(DashboardController());
  List<CompanyDetail>? companyList;

  @override
  void initState() {
    super.initState();
    final int? _userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productDetailsController.getProductDetails(
          companyId: widget.id, userId: _userId!);
      // fetchCompaniesList();
    });
  }

  bool qrShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Obx(
          () {
            if (productDetailsController.loading.value) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: CircularProgressIndicator(),
              ));
            }
            if (productDetailsController.productListData.isEmpty) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: Text("No data"),
              ));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sliderView(),
                SizedBox(height: 5),
                Text(productDetailsController.productListData.first.name ?? "",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
                Row(children: [
                  Text(
                      "₹ ${productDetailsController.productListData.first.marketPrice}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(width: 5),
                  Text(
                      "₹${productDetailsController.productListData.first.regularPrice}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.lineThrough)),
                  SizedBox(width: 10),
                  Text(
                      "${(((double.parse(productDetailsController.productListData.first.regularPrice ?? "") - (double.parse(productDetailsController.productListData.first.marketPrice ?? ""))) * 100) / double.parse(productDetailsController.productListData.first.regularPrice ?? "")).toStringAsFixed(1)} % OFF",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      )),
                ]),
                if (productDetailsController
                        .productListData.first.size?.isNotEmpty ??
                    false)
                  SizedBox(
                    height: 23,
                    child: Row(
                      children: [
                        if (productDetailsController
                                .productListData.first.size?.isNotEmpty ??
                            false)
                          Text("Size: ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              )),
                        SizedBox(width: 10),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: productDetailsController
                                .productListData.first.size!.length,
                            itemBuilder: (cxt, i) {
                              return InkWell(
                                onTap: () {
                                  selectedSize = <String>[];
                                  selectedSize.add(productDetailsController
                                      .productListData.first.size![i]);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: selectedSize.contains(
                                                  productDetailsController
                                                      .productListData
                                                      .first
                                                      .size![i])
                                              ? AdtipColors.black
                                              : AdtipColors.grey),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                      child: Text(
                                    productDetailsController
                                        .productListData.first.size![i],
                                    style: TextStyle(
                                        color: selectedSize.contains(
                                                productDetailsController
                                                    .productListData
                                                    .first
                                                    .size![i])
                                            ? AdtipColors.black
                                            : AdtipColors.grey),
                                  )),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              width: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                SizedBox(height: 5),
                ReadMoreText(
                  productDetailsController.productListData.first.description ??
                      "",
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'View more',
                  trimExpandedText: 'View less',
                  moreStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: userId ==
                            productDetailsController
                                .productListData.first.created_by,
                        child: CLoginButton(
                          height: 40,
                          title: 'Edit',
                          onTap: () {
                            showAlertDialog(context,
                                title: 'Edit',
                                subTitle: '"Would you like to edit product?"',
                                onTap: () async {
                              final int? userId = LocalPrefs().getIntegerPref(
                                  key: SharedPreferenceKey.UserId);

                              Navigator.of(context).pop();
                              var res = await NetworkApiServices().getApi(
                                  "${UrlConstants.BASE_URL}productbyproductid/${widget.id}/$userId");

                              Get.to(() => AddProductScreen(
                                        companyID: widget.companyID,
                                        data: res["data"],
                                        title: "Edit Product",
                                        isedit: true,
                                        productid: widget.id,
                                      ))!
                                  .then((value) => productDetailsController
                                      .getProductDetails(
                                          companyId: widget.id, userId: userId))
                                  .then((value) => productController.getProduct(
                                      companyId: widget.companyID));
                            });
                          },
                          buttonColor: AdtipColors.white,
                          textColor: AdtipColors.black,
                          showImage: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: userId ==
                            productDetailsController
                                .productListData.first.created_by,
                        child: CLoginButton(
                          height: 40,
                          title: 'Delete',
                          onTap: () async {
                            showAlertDialog(context,
                                title: "Delete",
                                subTitle: "Would you like to delete product?",
                                onTap: () async {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              productDetailsController.deleteProduct(
                                  productId: productDetailsController
                                          .productListData.first.id ??
                                      0);
                              await productController.getProduct(
                                  companyId: widget.companyID);
                            });
                          },
                          buttonColor: AdtipColors.black,
                          textColor: AdtipColors.white,
                          showImage: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context,
      {required Function() onTap,
      required String title,
      required String subTitle}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
        onPressed: onTap, child: Text("Yes", style: TextStyle(fontSize: 16)));

    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(subTitle, style: TextStyle(fontSize: 16)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  sliderView() {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount:
              productDetailsController.productListData.first.images!.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.only(top: 30),
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(productDetailsController
                      .productListData.first.images![index]),
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
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.95,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: productDetailsController.productListData.first.images!
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              return Container(
                width: activeIndex == index ? 18 : 8,
                height: 8,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: activeIndex == index
                      ? AdtipColors.black
                      : AdtipColors.white,
                ),
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Card(
                  elevation: 1,
                  shadowColor: AdtipColors.white,
                  color: AdtipColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.arrow_back_ios_new),
                  )),
            ),
            // InkWell(
            //   onTap: () async {
            //     await dynamicLinkHandler.createDynamicLink(
            //         productId:
            //             productDetailsController.productListData.first.id ?? 0,
            //         companyId: widget.companyID);
            //
            //     await Share.share(dynamicLinkHandler.linkMessage.value);
            //   },
            //   child: Icon(
            //     Icons.share,
            //     size: 25.h,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
