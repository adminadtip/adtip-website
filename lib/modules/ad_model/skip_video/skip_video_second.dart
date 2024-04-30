import 'package:adtip_web_3/modules/ad_model/skip_video/upload_video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import 'skip_video_controller.dart';
import 'widget/custom_video_player.dart';
import 'widget/drop/button/drop.dart';
import 'widget/drop/button/drop_controller.dart';
import 'widget/drop/display_ad/controller.dart';
import 'widget/drop/display_ad/dispaly_ad_drop.dart';
import 'widget/widget.dart';

class SkipVideoSecondScreen extends StatefulWidget {
  final String? title;
  final int oderValue;
  final String mediaType;
  final String campaign;
  final String modelId;
  final int? adPerViewPercentage;
  final String des;
  final String location;
  final String gst;
  final String website;
  final String? link;
  final String name;
  const SkipVideoSecondScreen({
    super.key,
    this.title,
    required this.oderValue,
    required this.mediaType,
    required this.campaign,
    required this.modelId,
    required this.adPerViewPercentage,
    required this.des,
    required this.gst,
    required this.website,
    required this.location,
    this.link,
    required this.name,
  });

  @override
  State<SkipVideoSecondScreen> createState() => _SkipVideoSecondScreenState();
}

class _SkipVideoSecondScreenState extends State<SkipVideoSecondScreen> {
  final TextEditingController displayController = TextEditingController();
  DropControllerBotton dropControllerBottom = Get.put(DropControllerBotton());
  DropDisplayAdController dropDisplayAdController =
      Get.put(DropDisplayAdController());
  final _formKey = GlobalKey<FormState>();
  late int _counter;
  void _remove() {
    setState(() {
      if (_counter > 30) {
        _counter = _counter - 10;
      }
    });
  }

  void _add() {
    setState(() {
      if (_counter < 100) {
        _counter = _counter + 10;
      }
    });
  }

  SkipVideoController skipVideoController =
      Get.put(SkipVideoController(), permanent: true);
  String text() {
    switch (widget.modelId) {
      case "1":
        return "Video";
      case "2":
        return "Video";
      case "3":
        return "Video";
      case "4":
        return "Image";
      case "5":
        return "Video";
      case "28":
        return "Image";
      case "29":
        return "Video/Image";
      default:
        return "Video/Image";
    }
  }

  TextEditingController displayC = TextEditingController();
  @override
  void initState() {
    dropControllerBottom.getButtonList();
    skipVideoController.imageUrl.value = '';
    if (skipVideoController.videoUrl.value.isEmpty) {
      skipVideoController.videoUrl.value = '';
    }

    text();
    _counter = widget.adPerViewPercentage ?? 30;
    setState(() {
      dropControllerBottom.selectData.value.name != null
          ? displayC.text = dropControllerBottom.selectData.value.id.toString()
          : "";
    });
    // if (widget.link != null) {
    //   print('link video ${widget.link}');
    //   Future.delayed(Duration(seconds: 2), () {
    //     print('link video ${widget.link}');
    //     skipVideoController.updateVideoUrlFromSelfChannel(widget.link!);
    //   });
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.adPerViewPercentage}99999");
    print(dropControllerBottom.selectData.value.id);
    print(displayC.text);

    return Scaffold(
      backgroundColor: AdtipColors.white,
      body: Center(
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Obx(
              () {
                if (skipVideoController.loadingButton.value) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 250),
                    child: CircularProgressIndicator(),
                  ));
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('After watching ad customer per view percentage?',
                          style: customStyle()),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_counter %", style: customStyle()),
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  InkWell(
                                      radius: 50,
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      splashColor:
                                          const Color.fromRGBO(52, 209, 191, 1),
                                      onTap: _remove,
                                      child: const Icon(Icons.remove)),
                                  const SizedBox(width: 5),
                                  Text(_counter.toString()),
                                  const SizedBox(width: 5),
                                  InkWell(
                                      radius: 50,
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      splashColor:
                                          const Color.fromRGBO(52, 209, 191, 1),
                                      onTap: _add,
                                      child: const Icon(Icons.add)),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ]),
                      const Divider(),
                      const SizedBox(height: 20),
                      Text('After watching ad customer per like percentage?',
                          style: customStyle()),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${100 - _counter} %",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  InkWell(
                                      radius: 50,
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      splashColor:
                                          const Color.fromRGBO(52, 209, 191, 1),
                                      onTap: _remove,
                                      child: const Icon(Icons.remove)),
                                  const SizedBox(width: 5),
                                  Text((100 - _counter).toString()),
                                  const SizedBox(width: 5),
                                  InkWell(
                                      radius: 50,
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      splashColor:
                                          const Color.fromRGBO(52, 209, 191, 1),
                                      onTap: _add,
                                      child: const Icon(Icons.add)),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ]),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text('Target button to displays', style: customStyle()),
                      TextFormField(
                        controller: displayC
                          ..text =
                              dropControllerBottom.selectData.value.name ?? "",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const DropDownBotton(),
                          );
                        },
                        validator: (value) {
                          print(value);
                          if (value == null || value.isEmpty) {
                            return "Field can't be blank";
                          }

                          return null;
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: 'Target button to display',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            )),
                      ),

                      const SizedBox(height: 20),

                      Text('Where to display ad?', style: customStyle()),

                      TextFormField(
                        validator: (value) {
                          print(value);
                          if (value == null || value.isEmpty) {
                            return "Field can't be blank";
                          }

                          return null;
                        },
                        controller: TextEditingController()
                          ..text =
                              dropDisplayAdController.selectedList.join(','),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const DropDownDisplayAd(),
                          );
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: 'Target display ad',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            )),
                      ),

                      // CustomDropDown(
                      //   backgroundColor: Colors.white,
                      //   dropdownItemStyle: customStyle(),
                      //   primaryColor: Colors.blue,
                      //   items: menuPlatform,
                      //   label: 'Target platform',
                      //   multiSelectTag: 'platform',
                      //   multiSelectValuesAsWidget: true,
                      //   decoration:
                      //       BoxDecoration(border: Border(bottom: BorderSide())),
                      //   multiSelect: true,
                      //   hideSearch: true,
                      //   labelStyle: customStyle(),
                      //   menuPadding: EdgeInsets.only(
                      //       bottom: 100.h, top: 100.h, left: 20.w, right: 20.w),
                      //   dropDownMenuItems: menuPlatform.map((item) {
                      //     return item;
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     print(value.toString());
                      //     if (value != null) {
                      //       selectedListPlatform = value;
                      //       print(selectedListPlatform.join(",").toString());
                      //     } else {
                      //       selectedListPlatform.clear();
                      //     }
                      //   },
                      // ),
                      const SizedBox(height: 20),
                      Text(
                        "Upload ${text()}",
                        style: GoogleFonts.poppins(
                            color: AdtipColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 17),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () {
                          print(
                              'video url in skip video ${skipVideoController.videoUrl.value}');
                          if (skipVideoController.videoUrl.value == '' ||
                              skipVideoController.videoUrl.value == null) {
                            return const SizedBox.shrink();
                          }
                          return CustomVideoPlayer(
                            videoUrl: skipVideoController.videoUrl.value,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () {
                          if (skipVideoController.imageUrl.value == '' ||
                              skipVideoController.imageUrl.value == null) {
                            return const SizedBox.shrink();
                          }
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      insetPadding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                            CachedNetworkImage(
                                              imageUrl: skipVideoController
                                                  .imageUrl.value,
                                              fit: BoxFit.fitHeight,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                'assets/images/noImage.jpg',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: CachedNetworkImage(
                              imageUrl: skipVideoController.imageUrl.value,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/noImage.jpg',
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: skipVideoController.loadingVideo.value
                              ? const Center(child: CircularProgressIndicator())
                              : CLoginButton(
                                  radius: 30,
                                  title: 'Upload',
                                  onTap: () {
                                    switch (widget.modelId) {
                                      case "1":
                                        skipVideoController.videoUpload();
                                      case "2":
                                        skipVideoController.videoUpload();
                                      case "3":
                                        skipVideoController.videoUpload();
                                      case "4":
                                        skipVideoController.imageUpload();
                                      case "5":
                                        skipVideoController.videoUpload();
                                      case "28":
                                        skipVideoController.imageUpload();
                                      case "29":
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Select"),
                                                actions: [
                                                  InkWell(
                                                    onTap: () {
                                                      skipVideoController
                                                          .imageUpload();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      "Image",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      skipVideoController
                                                          .videoUpload();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Video',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      default:
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Select"),
                                                actions: [
                                                  InkWell(
                                                    onTap: () {
                                                      skipVideoController
                                                          .imageUpload();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      "Image",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      skipVideoController
                                                          .videoUpload();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Video',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                    }
                                  },
                                  buttonColor: AdtipColors.white,
                                  textColor: AdtipColors.black,
                                  showImage: false,
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () {
                          return CLoginButton(
                            isLoading: skipVideoController.loadingSecond.value,
                            title: 'Next',
                            onTap: () {
                              if (skipVideoController.imageUrl.value != '' ||
                                  skipVideoController.videoUrl.value != '') {
                                if (_formKey.currentState!.validate()) {
                                  skipVideoController.saveSecondPageAdModel(
                                      adPerPreviewPercentage:
                                          _counter.toString(),
                                      adPerViewPercentage:
                                          (100 - _counter).toString(),
                                      adAnimationId: "2",
                                      adButtonTextId: dropControllerBottom
                                              .selectData.value.id ??
                                          0,
                                      adCommentsOn: "10",
                                      // dropDisplayAdController.selectedList
                                      //     .join(",")
                                      //     .toString(),
                                      adFile: skipVideoController
                                                  .imageUrl.value !=
                                              ""
                                          ? skipVideoController.imageUrl.value
                                          : skipVideoController.videoUrl.value,
                                      mediaType: "1",
                                      onSuccess: () {
                                        Get.to(UploadVideoSecondScreen(
                                          link: '',
                                          des: widget.des,
                                          gst: widget.gst,
                                          location: widget.location,
                                          website: widget.website,
                                          title: widget.title,
                                          campaign: widget.campaign,
                                          oderValue: widget.oderValue,
                                          name: widget.name,
                                        ));
                                      });
                                }
                              } else {
                                Get.snackbar("Please upload video", "",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            buttonColor: AdtipColors.black,
                            textColor: AdtipColors.white,
                            showImage: false,
                          );
                        },
                      ),
                      CLoginButton(
                        title: 'Back',
                        onTap: () {
                          Get.back();
                        },
                        buttonColor: AdtipColors.white,
                        textColor: AdtipColors.black,
                        showImage: false,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
