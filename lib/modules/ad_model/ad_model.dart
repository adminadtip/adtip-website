import 'package:adtip_web_3/modules/ad_model/skip_video/skip_video.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/constants/Loader.dart';
import '../../helpers/constants/asset_files.dart';
import '../../helpers/constants/colors.dart';
import '../../helpers/local_database/local_prefs.dart';
import '../../helpers/local_database/sharedpref_key.dart';
import '../createCompany/controller/imageItem.dart';
import 'controllers/ad_models_controller.dart';
import 'skip_video/widget/custom_video_player.dart';

class AdModelScreen extends StatefulWidget {
  final String? link;
  AdModelScreen({super.key, this.link});

  @override
  State<AdModelScreen> createState() => _AdModelScreenState();
}

class _AdModelScreenState extends State<AdModelScreen> {
  final AdModelsController adModelsController =
      Get.put(AdModelsController(), permanent: true);
  @override
  void initState() {
    super.initState();
    adModelsController.getAdModelsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Obx(
              () {
                if (adModelsController.loading.value) {
                  return const Loader();
                }
                return Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: adModelsController.adModelData.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return customContainer(
                              discount: adModelsController
                                  .adModelData[i].discount
                                  .toString(),
                              basePrice: adModelsController
                                  .adModelData[i].basePrice
                                  .toString(),
                              viewPrice: adModelsController
                                  .adModelData[i].viewPrice
                                  .toString(),
                              url:
                                  "${adModelsController.adModelData[i].modelImage}",
                              title:
                                  adModelsController.adModelData[i].name ?? "",
                              onTap: () {
                                Get.to(
                                  SkipVideoScreen(
                                    viewPrice: adModelsController
                                        .adModelData[i].viewPrice,
                                    link: widget.link,
                                    mediaType: adModelsController
                                        .adModelData[i].mediaType,
                                    modelId: adModelsController
                                        .adModelData[i].id
                                        .toString(),
                                    title: adModelsController
                                            .adModelData[i].name ??
                                        "",
                                  ),
                                );
                              });
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget customContainer(
      {required String title,
      required Function() onTap,
      required String url,
      required String basePrice,
      required String viewPrice,
      required String discount}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SizedBox(
            // height: 294.h,
            child: Column(
              children: [
                Image.network(
                  url,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  subtitle: Text(
                      "Short $title between WeTube video have high click thourgh rate.",
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                ),
                const Divider(
                    color: AdtipColors.grey, indent: 10, endIndent: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (LocalPrefs().getIntegerPref(
                                key: SharedPreferenceKey.UserId,
                              ) !=
                              null) {
                            onTap();
                          }
                        },
                        child: Text(
                          "Book Now",
                          style: GoogleFonts.poppins(
                              color: AdtipColors.lightBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                insetPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.cancel),
                                          )),
                                      const SizedBox(height: 10),
                                      const CustomVideoPlayer(
                                          height: 210,
                                          videoUrl:
                                              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      label: Text(
                        "Watch Video",
                        style: GoogleFonts.poppins(
                            color: AdtipColors.brown,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      icon: Image.asset(
                        AdtipAssets.PLAY_ICON,
                        height: 17,
                        width: 17,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\u{20B9}$basePrice",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: AdtipColors.darkred,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "\u{20B9}$viewPrice",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: AdtipColors.darkred,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
