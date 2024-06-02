import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

import '../../../helpers/utils/utils.dart';
import '../models/webrtc_signaling.dart';

class CallingController extends GetxController {
  Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  Rx<bool> isAudioOn = true.obs;
  Rx<bool> speakerOn = true.obs;
  Rx<String> roomId = ''.obs;

  initLocalRender() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  toggleMic() {
    // change status
    isAudioOn.value = !isAudioOn.value;
    // enable or disable audio track
    signaling.localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn.value;
    });
  }

  toggleSpeaker() {
    // change status
    speakerOn.value = !speakerOn.value;
    // enable or disable audio track
    signaling.remoteStream?.getAudioTracks().forEach((track) {
      track.enableSpeakerphone(speakerOn.value);
    });
  }

  initAudioCall({required String deviceToken}) async {
    try {
      initLocalRender();
      signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });
      await signaling
          .openUserMedia(_localRenderer, _remoteRenderer)
          .then((value) {});
      signaling.createRoom(_remoteRenderer).then((value) async {
        roomId.value = value;
        await Utils.sendNotification(
            title: 'Call from adtip',
            subtitle: value,
            token:
                'c4mzeWryRTSvTCDSvzihXg:APA91bHCZG6V7x4TiOsjjM2rO1z5bWowJOFdck9rWfjYZVxqJkQojGQgDnGdceeYrJzvLLSShQ28Gu0h8PY4_d4E7QfdZ9li9IHbOC7uGToTac9nzqY7yYSznSqhOYso2YMpwaPiO0iI');
      });
    } catch (e) {}
  }

  hangup() async {
    try {
      await signaling.hangUp(_localRenderer);
      Get.back();
    } catch (e) {}
  }
}
//dL9dHa2-SCKYK7AEA1OTj4:APA91bHaMLtQHG9geQI9oTfBaVlFQm30kaFZZi2oVe2mS4w4imYrQwmbXAwo6h9pJAyrtDgujOjZbVqAJXIWc4jNu5q5J0FQ9MS6aNjRjiiIXQmtoYA6V00a_rA6s_alOSsCbFlh736P
