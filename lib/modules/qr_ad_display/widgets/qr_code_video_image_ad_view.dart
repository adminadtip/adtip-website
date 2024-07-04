import 'dart:async';

import 'package:adtip_web_3/helpers/constants/string_constants.dart';
import 'package:adtip_web_3/modules/qr_ad_display/pages/qr_ad_details.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/utils/utils.dart';
import '../../createCompany/controller/imageItem.dart';
import '../controller/qr_ad_controller.dart';
import '../models/company_list_model.dart';
import '../models/qr_ad_details_model.dart';
import 'custom_image_view.dart';

class QrCodeImageVideoView extends StatefulWidget {
  const QrCodeImageVideoView({
    super.key,
    required this.qrAdDetailsModel,
  });

  final QrAdDetailsModel qrAdDetailsModel;

  @override
  State<QrCodeImageVideoView> createState() => _QrCodeImageVideoViewState();
}

class _QrCodeImageVideoViewState extends State<QrCodeImageVideoView> {
  bool liked = false;
  QrCodeAdDisplayController qrCodeAdDisplayController =
      Get.put(QrCodeAdDisplayController());
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  int _timerCount = 30;
  bool _timerActive = true;
  late Timer _periodicTimer;
  bool isMuted = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qrCodeAdDisplayController.checkAdValid(widget.qrAdDetailsModel.adId);
    initializeVideo();
    //_startTimer();
  }

  void _startTimer() {
    _periodicTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timerActive && _timerCount > 0) {
          _timerCount--;
        } else {
          // If the timer reaches 1 second or is paused, stop it
          _periodicTimer.cancel();
          videoPlayerController.pause();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Wow!, You earned ₹3,'),
                  content: const Text('Fill the form to get the money.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.to(QrAddDetails(
                              companyId: widget.qrAdDetailsModel.companyId,
                              adId: widget.qrAdDetailsModel.adId,
                              companyName:
                                  widget.qrAdDetailsModel.companyName ?? ''));
                        },
                        child: const Text('Fill Form')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'))
                  ],
                );
              });
        }
      });
      print("Timer: $_timerCount seconds");
    });
  }

  void _toggleTimer() {
    setState(() {
      _timerActive = !_timerActive;
    });

    if (_timerActive) {
      // Resume the timer if it's paused
      _startTimer();
    } else {
      // Pause the timer
      _periodicTimer?.cancel();
    }
  }

  void initializeVideo() {
    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.qrAdDetailsModel.adUrl))
      ..initialize().then((_) {
        videoPlayerController.setVolume(0);
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        setState(() {});
      });

    videoPlayerController.addListener(_videoPlayerListener);
    // videoPlayerController.addListener(() async {
    //   if (videoPlayerController.value.isInitialized &&
    //       videoPlayerController.value.isCompleted) {
    //     if (widget.adId != null) {
    //       await weTubeController.saveAdViewAmount(
    //           adId: widget.adId!, context: context);
    //     }
    //   }
    // });
  }

  Future<void> _videoPlayerListener() async {
    final position = videoPlayerController.value.position;
    if (position.inSeconds > 0) {
      _startTimer();
    }
    if (videoPlayerController.value.isPlaying) {
      _toggleTimer();
    } else {
      _toggleTimer();
    }

    if (videoPlayerController.value.isInitialized &&
        videoPlayerController.value.isCompleted) {}

    videoPlayerController.removeListener(_videoPlayerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _periodicTimer.cancel();
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kDebugMode) {
      print('cover image ${widget.qrAdDetailsModel.companyProfile}');
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopScope(
        canPop: false,
        onPopInvoked: (value) async {
          return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Wait! You're loosing money!"),
                  content: const Text('Continue Watching to earn cash'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          videoPlayerController.play();
                          videoPlayerController.dispose();
                          _periodicTimer.cancel();
                        });
                      },
                      child: const Text('Skip'),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            videoPlayerController!.value.isPlaying
                                ? videoPlayerController.pause()
                                : videoPlayerController.play();

                            _toggleTimer();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Continue Watching')),
                  ],
                );
              });
        },
        child: Scaffold(body: Obx(() {
          if (qrCodeAdDisplayController.checkingAdValid.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (qrCodeAdDisplayController.isValid.value == 0) {
            _periodicTimer.cancel();
            videoPlayerController.dispose();
            chewieController?.dispose();
            return Center(
              child: InkWell(
                onTap: () {
                  Utils.launchWeb(
                      uri: Uri.parse(StringConstants.googlePlayLink));
                },
                child: Column(
                  children: [
                    const Text('Out of ads, download Adtip from play store'),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/googleplay.png',
                      height: 100,
                    )
                  ],
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              widget.qrAdDetailsModel.companyProfile ?? '',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 100,
                              child: Text(
                                "Complete watching the ad to earn upto ₹100",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.qrAdDetailsModel.companyName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        if (widget.qrAdDetailsModel.adWebsite !=
                                            '') {
                                          await Utils.launchWeb(
                                              uri: Uri.parse(
                                                  '${widget.qrAdDetailsModel.adWebsite}'));
                                        }
                                      },
                                      child: Text(
                                        widget.qrAdDetailsModel.adWebsite,
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Colors.black, // optional
                                          decorationThickness: 2, // optional
                                          decorationStyle: TextDecorationStyle
                                              .solid, // optional
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Image.asset(
                                      AdtipAssets.ARROW_UP,
                                      height: 15,
                                      width: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Utils.showAlertDialogForQrAdVideo(
                                            context: context,
                                            title: 'Install app to follow');
                                      },
                                      child: const Text(
                                        "Follow",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        isVideo(
                          url: widget.qrAdDetailsModel.adUrl,
                        )
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 300,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: VideoPlayer(videoPlayerController),
                                    ),
                                    if (_timerCount > 0)
                                      Positioned(
                                          right: 0,
                                          bottom: 10,
                                          child: Container(
                                            width: 80,
                                            height: 30,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Skip Ad $_timerCount',
                                                  style: GoogleFonts.inder(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                                const Icon(
                                                  Icons.play_arrow,
                                                  size: 12,
                                                )
                                              ],
                                            ),
                                          ))
                                    else
                                      Positioned(
                                          right: 0,
                                          bottom: 10,
                                          child: InkWell(
                                            onTap: () {
                                              videoPlayerController.pause();

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Wow!, You earned ₹3,'),
                                                      content: const Text(
                                                          'Fill the form to get the money.'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Get.to(QrAddDetails(
                                                                  companyId: widget
                                                                      .qrAdDetailsModel
                                                                      .companyId,
                                                                  adId: widget
                                                                      .qrAdDetailsModel
                                                                      .adId,
                                                                  companyName: widget
                                                                      .qrAdDetailsModel
                                                                      .companyName));
                                                            },
                                                            child: const Text(
                                                                'Fill Form')),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cancel'))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 30,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Skip Ad',
                                                    style: GoogleFonts.inder(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                  const Icon(
                                                    Icons.play_arrow,
                                                    size: 12,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                  ],
                                ),
                              )
                            : CustomImageView(
                                imagePath: widget.qrAdDetailsModel.adUrl,
                                height: size.height * 0.3,
                                width: double.infinity,
                              ),
                        !videoPlayerController.value.isInitialized
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (videoPlayerController
                                            .value.isPlaying) {
                                          videoPlayerController.pause();
                                          _toggleTimer();
                                        } else {
                                          videoPlayerController.play();
                                          _toggleTimer();
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      videoPlayerController.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 64,
                                    ),
                                    // color: Colors.white,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (isMuted) {
                                          videoPlayerController.setVolume(1.0);
                                        } else {
                                          videoPlayerController.setVolume(0.0);
                                        }
                                        isMuted = !isMuted;
                                      });
                                    },
                                    icon: isMuted
                                        ? const Icon(
                                            Icons.volume_off,
                                            size: 64,
                                          )
                                        : const Icon(
                                            Icons.volume_up,
                                            size: 64,
                                          ),
                                  ),
                                  if (_timerCount > 0)
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          videoPlayerController!.value.isPlaying
                                              ? videoPlayerController?.pause()
                                              : videoPlayerController?.play();

                                          _toggleTimer();
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Wait! You're loosing money!"),
                                                content: const Text(
                                                    'Continue Watching to earn ₹3'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        _periodicTimer.cancel();
                                                      });
                                                      Utils.launchWeb(
                                                          uri: Uri.parse(
                                                              StringConstants
                                                                  .googlePlayLink));
                                                    },
                                                    child: const Text('Skip'),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          videoPlayerController!
                                                                  .value
                                                                  .isPlaying
                                                              ? videoPlayerController
                                                                  ?.pause()
                                                              : videoPlayerController
                                                                  ?.play();

                                                          _toggleTimer();
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                          'Continue Watching')),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 64,
                                      ),
                                    )
                                ],
                              ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     left: size.width * 0.05,
                        //     right: size.width * 0.05,
                        //     top: size.width * 0.05,
                        //   ),
                        //   child: Text(
                        //     widget.getCompanyModel.data.isEmpty
                        //         ? ''
                        //         : widget.getCompanyModel.data[0].about!,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Utils.showAlertDialogForQrAdVideo(
                                      context: context,
                                      title: 'Install app to chat');
                                },
                                child: const Text(
                                  "CHAT",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Utils.showAlertDialogForQrAdVideo(
                                      context: context,
                                      title: 'Install app to follow');
                                },
                                child: const Text(
                                  "COMMENT",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              if (_timerCount > 0)
                                Row(
                                  children: [
                                    Text(_timerCount.toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.thumb_up)
                                  ],
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    if (!liked) {
                                      videoPlayerController.pause();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Wow!, You earned ₹3,'),
                                              content: const Text(
                                                  'Fill the form to get the money.'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Get.to(QrAddDetails(
                                                          companyId: widget
                                                              .qrAdDetailsModel
                                                              .companyId,
                                                          adId: widget
                                                              .qrAdDetailsModel
                                                              .adId,
                                                          companyName: widget
                                                              .qrAdDetailsModel
                                                              .companyName));
                                                    },
                                                    child: const Text(
                                                        'Fill Form')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Cancel'))
                                              ],
                                            );
                                          });
                                    }
                                    setState(() {
                                      liked = true;
                                    });
                                  },
                                  child: Icon(
                                    liked
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_alt_outlined,
                                  ),
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
          );
        })),
      ),
    );
  }

  bool isVideo({required String url}) {
    return url.endsWith('.mp4') ||
        url.endsWith('.avi') ||
        url.endsWith('.mkv') ||
        url.endsWith('.webm') ||
        url.endsWith('.mov');
  }
}
