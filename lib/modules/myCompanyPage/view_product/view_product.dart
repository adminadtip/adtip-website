import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/constants/colors.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../page/add_product_page.dart';
import '../view_product_details/view_product_detail_controller.dart';
import '../view_product_details/view_product_details.dart';
import 'view_product_controller.dart';

class ViewProductScreen extends StatefulWidget {
  final String id;
  final String companyID;
  ViewProductScreen({
    super.key,
    required this.id,
    required this.companyID,
  });

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final ProductController productController = Get.put(ProductController());

  DashboardController dashBoardController = Get.put(DashboardController());

  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  @override
  void initState() {
    productController.getProduct(companyId: widget.id);

    super.initState();
  }

  int userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Products',
          style: TextStyle(
              color: AdtipColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(
        () {
          if (productController.loading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (productController.productListData.isEmpty) {
            return Center(
                child: Text(
              "No Data is available",
              style: TextStyle(fontSize: 14),
            ));
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: productController.productListData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                mainAxisExtent: MediaQuery.of(context).size.height * .320),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.to(
                    ProductDetailScreen(
                      id: productController.productListData[index].id ?? 0,
                      companyID: widget.companyID,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: productController.productListData[index].images
                              ?.split(',')
                              .first ??
                          "",
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/noImage.jpg',
                      ),
                    ),
                    SizedBox(height: 2),
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
                    Text(productController.productListData[index].name ?? ""),
                    Text(
                        "₹ ${productController.productListData[index].marketPrice}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
              );
            },
          );
        },
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
              padding: EdgeInsets.only(top: 7, bottom: 7),
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, .7),
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
                      var res = await NetworkApiServices().getApi(
                          "${UrlConstants.BASE_URL}productbyproductid/$id/$userId");

                      Get.to(() => AddProductScreen(
                                companyID: widget.companyID,
                                data: res["data"],
                                title: "Edit Product",
                                isedit: true,
                                productid: id,
                              ))!
                          .then((value) => productController.getProduct(
                              companyId: widget.companyID));
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(0, 122, 255, 1)),
                    ),
                  ),
                  Divider(
                    color: AdtipColors.grey,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();

                      showAlertDialog(context,
                          title: "Delete",
                          subTitle: "Would you like to delete product?",
                          onTap: () async {
                        Navigator.of(context).pop();

                        await productDetailsController.deleteProduct(
                            productId: id);

                        await productController.getProduct(
                            companyId: widget.companyID);
                      });
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 20, color: AdtipColors.red),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 40),
              child: MaterialButton(
                height: 45,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AdtipColors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
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
}
