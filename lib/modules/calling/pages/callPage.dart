import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/calling/controllers/calling_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

import '../models/webrtc_signaling.dart';

class CallingPage extends StatefulWidget {
  final String deviceToken;
  const CallingPage({super.key, required this.deviceToken});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  CallingController callingController = Get.put(CallingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callingController.initAudioCall(deviceToken: widget.deviceToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4B4D),
      body: Column(
        children: [
          const Spacer(),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                        onPressed: () async {
                          await callingController.hangup();
                        },
                        icon: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                        ))),
                const SizedBox(
                  width: 30,
                ),
                CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          callingController.toggleMic();
                        },
                        icon: callingController.isAudioOn.value
                            ? const Icon(Icons.mic)
                            : const Icon(Icons.mic_off))),
                const SizedBox(
                  width: 30,
                ),
                CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          callingController.toggleSpeaker();
                        },
                        icon: callingController.speakerOn.value
                            ? const Icon(Icons.volume_up)
                            : const Icon(Icons.volume_off))),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
