import 'dart:convert';
import 'dart:math';
import 'package:adtip_web_3/modules/ad_model/page/graph/widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'duration/controller.dart';
import 'lead_controller.dart';

class LineChartpage extends StatefulWidget {
  const LineChartpage({super.key});

  @override
  State<LineChartpage> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartpage> {
  bool showAvg = false;
  LeadController leadController = Get.put(LeadController());
  DropDurationController skipVideoController =
      Get.put(DropDurationController());
  LineChartBarData get likeChart => LineChartBarData(
        spots: [
          ...leadController.isLikeData.map((e) {
            return FlSpot((e.xAxis?.toDouble() ?? 0), e.count?.toDouble() ?? 0);
          }).toList()
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColorLike,
        ),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColorLike
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      );
  LineChartBarData get viewChart => LineChartBarData(
        spots: [
          ...leadController.isViewData.map((e) {
            return FlSpot((e.xAxis?.toDouble() ?? 0), e.count?.toDouble() ?? 0);
          }).toList()
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColorLike,
        ),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColorLike
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      );
  LineChartBarData get followChart => LineChartBarData(
        spots: [
          ...leadController.isFollowData.map((e) {
            return FlSpot((e.xAxis?.toDouble() ?? 0), e.count?.toDouble() ?? 0);
          }).toList()
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColorLike,
        ),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColorLike
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    print("${leadController.selectedIndex.value}isViewData");

    return Obx(
      () {
        if (leadController.loading.value) {
          return const Center(child: Text("Loading....."));
        }
        if (leadController.isLikeData.isEmpty &&
            leadController.isViewData.isEmpty &&
            leadController.isFollowData.isEmpty) {
          return const Center(child: Text("No Data is Available"));
        }
        return AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: LineChart(
              mainData(),
            ),
          ),
        );
      },
    );
  }

  LineChartData mainData() {
    return LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              interval: 1,
              getTitlesWidget: skipVideoController.selectData.value ==
                      "Last 7 days"
                  ? bottomTitleWidgetsWeek
                  : skipVideoController.selectData.value == "Current Year"
                      ? bottomTitleWidgetsMonth
                      : skipVideoController.selectData.value == "Lifetime"
                          ? bottomTitleWidgetsYear
                          : skipVideoController.selectData.value == "Yesterday"
                              ? bottomTitleWidgetsHour
                              : skipVideoController.selectData.value == "Today"
                                  ? bottomTitleWidgetsHour
                                  : bottomTitleWidgetsWeek,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: leadController.interval.value,
              reservedSize: 60,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: skipVideoController.selectData.value == "Last 7 days"
            ? 7
            : skipVideoController.selectData.value == "Current Year"
                ? 12
                : skipVideoController.selectData.value == "Lifetime"
                    ? 7
                    : skipVideoController.selectData.value == "Yesterday"
                        ? 24
                        : skipVideoController.selectData.value == "Today"
                            ? 24
                            : 7,
        minY: 0,
        maxY: leadController.maxCount.toDouble() * 1.5,
        lineBarsData: leadController.selectedIndex.value == 1
            ? [viewChart]
            : leadController.selectedIndex.value == 2
                ? [likeChart]
                : leadController.selectedIndex.value == 3
                    ? [followChart]
                    : [viewChart, likeChart, followChart]);
  }
}
