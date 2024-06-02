import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../calling/pages/callPage.dart';
import 'lead_controller.dart';
import 'model/graph_model.dart';

final List<Color> gradientColorsView = [
  const Color.fromRGBO(217, 186, 131, .2),
  const Color.fromRGBO(217, 186, 131, 1),
];
final List<Color> gradientColorLike = [
  const Color.fromRGBO(103, 189, 140, .2),
  const Color.fromRGBO(103, 189, 140, 1),
];
final List<Color> gradientColorLead = [
  const Color.fromRGBO(26, 53, 221, .2),
  const Color.fromRGBO(26, 53, 221, 1),
];

Widget bottomTitleWidgetsWeek(double value, TitleMeta meta) {
  TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  String? text;
  switch (value) {
    case 0:
      text = '';
      break;
    case 1:
      text = 'Sun';
      break;
    case 2:
      text = 'Mon';
      break;
    case 3:
      text = 'Tue';
      break;
    case 4:
      text = 'Wed';
      break;
    case 5:
      text = 'Thur';
      break;
    case 6:
      text = 'Fri';
      break;
    case 7:
      text = 'Sat';
      break;
    default:
      text = "";
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}

Widget bottomTitleWidgetsMonth(double value, TitleMeta meta) {
  TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  String? text;
  switch (value) {
    case 0:
      text = '';
      break;
    case 1:
      text = 'Jan';
      break;
    case 2:
      text = 'Feb';
      break;
    case 3:
      text = 'Mar';
      break;
    case 4:
      text = 'Apr';
      break;
    case 5:
      text = 'May';
      break;
    case 6:
      text = 'Jun';
      break;
    case 7:
      text = 'July';
      break;
    case 8:
      text = 'Aug';
      break;
    case 9:
      text = 'Sep';
      break;
    case 10:
      text = 'Oct';
      break;
    case 11:
      text = 'Nov';
      break;
    case 12:
      text = 'Dec';
      break;
    default:
      text = "";
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}

Widget bottomTitleWidgetsHour(double value, TitleMeta meta) {
  TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(value.toString(), style: style),
  );
}

Widget bottomTitleWidgetsYear(double value, TitleMeta meta) {
  TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  String? text;
  switch (value) {
    case 0:
      text = '';
      break;
    case 1:
      text = '24';
      break;
    case 2:
      text = '25';
      break;
    case 3:
      text = '26';
      break;
    case 4:
      text = '27';
      break;
    case 5:
      text = '28';
      break;
    case 6:
      text = '29';
      break;
    case 7:
      text = '30';
      break;
    case 8:
      text = '31';
      break;
    case 9:
      text = '32';
      break;
    case 10:
      text = '33';
      break;
    case 11:
      text = '34';
      break;
    case 12:
      text = '35';
      break;
    case 13:
      text = '36';
      break;
    default:
      text = "";
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}

Widget list(List<IsLikeUserList> isFollowUserData) {
  LeadController leadController = Get.put(LeadController());

  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isFollowUserData.length,
      itemBuilder: (context, i) {
        return ListTile(
            onTap: () {
              print('device token ${isFollowUserData[i].deviceToken!}');
              print('user id ${isFollowUserData[i].id!}');
              if (isFollowUserData[i].deviceToken != null) {
                Get.to(CallingPage(
                  deviceToken: isFollowUserData[i].deviceToken!,
                ));
              } else {
                Utils.showErrorMessage('Cannot call');
              }
            },
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  isFollowUserData[i].profileImage ?? ""),
            ),
            title: Text(isFollowUserData[i].name ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            trailing: leadController.selectedIndex.value == 2
                ? const Icon(Icons.call, color: Colors.green, size: 18)
                : leadController.selectedIndex.value == 1 ||
                        leadController.selectedIndex.value == 2 ||
                        leadController.selectedIndex.value == 3
                    ? InkWell(
                        onTap: () {
                          // Utils.navigationToAnyPage(
                          //     context,
                          //     ScreenMessageChat(
                          //         Utils.fetchCurrentUserFromLocalPreference(),
                          //         isFollowUserData[i].id!));
                        },
                        child: Image.asset('assets/images/Right.png'),
                      )
                    : const SizedBox());
      });
}
