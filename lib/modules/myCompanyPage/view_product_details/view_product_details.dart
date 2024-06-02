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
import '../../ad_model/controllers/ad_models_controller.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/my_company_controller.dart';
import '../page/add_product_page.dart';
import '../view_product/view_product_controller.dart';
import 'view_product_detail_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
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
  final adModelsController = Get.put(AdModelsController());
  final createCompanyController = Get.put(CreateCompanyController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final int? _userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productDetailsController.getProductDetails(
          productId: productDetailsController.selectedProductId.value,
          userId: _userId!);
      // fetchCompaniesList();
    });
  }

  bool qrShow = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Obx(
            () {
              if (productDetailsController.loading.value) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: CircularProgressIndicator(),
                ));
              }
              if (productDetailsController.productListData.isEmpty) {
                return const Center(
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
                  const SizedBox(height: 5),
                  Text(
                      productDetailsController.productListData.first.name ?? "",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  Row(children: [
                    Text(
                        "₹ ${productDetailsController.productListData.first.marketPrice}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(width: 5),
                    Text(
                        "₹${productDetailsController.productListData.first.regularPrice}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.lineThrough)),
                    const SizedBox(width: 10),
                    Text(
                        "${(((double.parse(productDetailsController.productListData.first.regularPrice ?? "") - (double.parse(productDetailsController.productListData.first.marketPrice ?? ""))) * 100) / double.parse(productDetailsController.productListData.first.regularPrice ?? "")).toStringAsFixed(1)} % OFF",
                        style: const TextStyle(
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
                            const Text("Size: ",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                )),
                          const SizedBox(width: 10),
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
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
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
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  const SizedBox(height: 5),
                  ReadMoreText(
                    productDetailsController
                            .productListData.first.description ??
                        "",
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'View more',
                    trimExpandedText: 'View less',
                    moreStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
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
                                  subTitle: "Would you like to edit product?",
                                  onTap: () async {
                                final int? userId = LocalPrefs().getIntegerPref(
                                    key: SharedPreferenceKey.UserId);

                                Navigator.of(context).pop();
                                // var res = await NetworkApiServices().getApi(
                                //     "${UrlConstants.BASE_URL}productbyproductid/${productDetailsController.selectedProductId.value}/$userId");
                                //

                                productDetailsController
                                    .setEditOrAddProductValue(
                                        heading: 'Edit Product', edit: true);
                                dashBoardController.changeWidget(value: 7);

                                // Get.to(() => AddProductScreen(
                                //           data: res["data"],
                                //           title: "Edit Product",
                                //           isedit: true,
                                //           productid: productDetailsController
                                //               .selectedProductId,
                                //         ))!
                                //     .then((value) => productDetailsController
                                //         .getProductDetails(
                                //             productId: productDetailsController
                                //                 .selectedProductId,
                                //             userId: userId));
                                // .then((value) => productController.getProduct(
                                //     companyId: widget.id.toString()));
                              });
                            },
                            buttonColor: AdtipColors.white,
                            textColor: AdtipColors.black,
                            showImage: false,
                          ),
                        ),
                      ),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
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
                                        subTitle:
                                            "Would you like to delete product?",
                                        onTap: () async {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await productDetailsController
                                          .deleteProduct(
                                              productId:
                                                  productDetailsController
                                                      .selectedProductId.value);
                                      await productController.getProduct(
                                          companyId: createCompanyController
                                              .selectedCompanyId.value
                                              .toString());
                                      setState(() {
                                        isLoading = false;
                                      });
                                      dashBoardController.changeWidget(
                                          value: 0);
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CLoginButton(
                            title: 'Back',
                            buttonColor: Colors.black,
                            textColor: Colors.white,
                            showImage: false,
                            onTap: () {
                              dashBoardController.changeWidget(value: 0);
                            }),
                      ),
                      Expanded(
                        child: CLoginButton(
                            title: 'Promote',
                            buttonColor: Colors.green,
                            textColor: Colors.white,
                            showImage: false,
                            onTap: () {
                              adModelsController.promoteLink.value =
                                  'https://adtip.in/mob/Product/?productId=${productDetailsController.selectedProductId.value}&companyId=${controller.selectedCompanyId.value}';
                              dashBoardController.changeWidget(value: 11);
                            }),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
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
      child: const Text("No", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
        onPressed: onTap,
        child: const Text("Yes", style: TextStyle(fontSize: 16)));

    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(subTitle, style: const TextStyle(fontSize: 16)),
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
              margin: const EdgeInsets.only(top: 30),
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
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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
      ],
    );
  }
}
