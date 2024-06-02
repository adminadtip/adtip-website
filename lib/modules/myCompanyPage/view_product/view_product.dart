import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/constants/colors.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../../widgets/html_image_render.dart';
import '../../ad_model/controllers/ad_models_controller.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../page/add_product_page.dart';
import '../view_product_details/view_product_detail_controller.dart';
import '../view_product_details/view_product_details.dart';
import 'view_product_controller.dart';
import 'dart:ui' as ui;

class ViewProductScreen extends StatefulWidget {
  ViewProductScreen({
    super.key,
  });

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final ProductController productController = Get.put(ProductController());

  DashboardController dashBoardController = Get.put(DashboardController());
  final companyController = Get.put(CreateCompanyController());
  final adModelsController = Get.put(AdModelsController());

  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  @override
  void initState() {
    productController.getProduct(
        companyId: companyController.selectedCompanyId.value.toString());

    super.initState();
  }

  int userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Obx(
          () {
            if (productController.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (productController.productListData.isEmpty) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/blank.png'),
                    const SizedBox(height: 10),
                    const Text(
                      'No products yet',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You haven’t added any product yet. Add product to showcase to customers',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CLoginButton(
                      title: "Add Product",
                      onTap: () {
                        productDetailsController.setEditOrAddProductValue(
                            heading: 'Add Product', edit: false);
                        dashBoardController.changeWidget(value: 7);
                      },
                      buttonColor: AdtipColors.black,
                      textColor: AdtipColors.white,
                      showImage: false,
                    )
                  ]);
            }
            return SizedBox(
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your products'),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: productController.productListData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * .320),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print('clicked');
                            }
                            productDetailsController.selectedProductId.value =
                                productController.productListData[index].id!;
                            dashBoardController.changeWidget(value: 18);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: productController
                                        .productListData[index].images
                                        ?.split(',')
                                        .first ??
                                    "",
                                width: 140,
                                height: 140,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/noImage.jpg',
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     MaterialButton(
                              //       color: Colors.white,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(5)),
                              //       elevation: 2,
                              //       height: 23.h,
                              //       onPressed: () async {
                              //         await dynamicLinkHandler.createDynamicLink(
                              //             productId: productController
                              //                     .productListData[index].id ??
                              //                 0,
                              //             companyId: widget.companyID);
                              //         Get.close(3);
                              //         // dashBoardController.pageChange(0);
                              //         // await Get.to(CartPage(
                              //         //     link: dynamicLinkHandler.linkMessage.value)
                              //         // );
                              //       },
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Text(
                              //             'Promote',
                              //             style: TextStyle(
                              //                 fontSize: 13.sp,
                              //                 color: AdtipColors.black,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //           SizedBox(width: 2.w),
                              //           Image.asset(
                              //             'assets/images/share.png',
                              //             height: 12.h,
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //     SizedBox(width: 2.w),
                              //     InkWell(
                              //         onTap: () {
                              //           Get.bottomSheet(bottomSheet(
                              //               id: productController
                              //                       .productListData[index].id ??
                              //                   0));
                              //         },
                              //         child: Icon(Icons.more_vert_rounded))
                              //   ],
                              // ),
                              Text(productController
                                      .productListData[index].name ??
                                  ""),
                              Text(
                                  "₹ ${productController.productListData[index].marketPrice}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    adModelsController.promoteLink.value =
                                        'https://adtip.in/mob/Product/?productId=${productController.productListData[index].id}&companyId=${companyController.selectedCompanyId.value}';
                                    dashBoardController.changeWidget(value: 11);
                                  },
                                  child: const Text(
                                    'Promote',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bottomSheet({required int id}) {
    return Container(
        width: double.infinity,
        color: AdtipColors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 7, bottom: 7),
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 245, 245, .7),
                  borderRadius: BorderRadiusDirectional.circular(10)),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final int? userId = LocalPrefs()
                          .getIntegerPref(key: SharedPreferenceKey.UserId);

                      Navigator.of(context).pop();
                      productDetailsController.setEditOrAddProductValue(
                          heading: 'Edit Product', edit: true);
                      dashBoardController.changeWidget(value: 7);
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(0, 122, 255, 1)),
                    ),
                  ),
                  const Divider(
                    color: AdtipColors.grey,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();

                      showAlertDialog(context,
                          title: "Delete",
                          subTitle: "Would you like to delete product?",
                          onTap: () async {
                        await productDetailsController.deleteProduct(
                            productId: id);

                        await productController.getProduct(
                            companyId: companyController.selectedCompanyId.value
                                .toString());
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 20, color: AdtipColors.red),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 40),
              child: MaterialButton(
                height: 45,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AdtipColors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Share",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(0, 122, 255, 1)),
                ),
              ),
            )
          ],
        ));
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
}
