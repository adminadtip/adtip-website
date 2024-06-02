import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helpers/constants/colors.dart';
import '../../controllers/order_controller.dart';
import '../../models/order_list.dart';
import 'compaign/drop.dart';
import 'duration/controller.dart';
import 'duration/gender_drop.dart';
import 'follows_list.dart';
import 'lead_controller.dart';
import 'leadchart.dart';
import 'widget.dart';

class MyLeadPage extends StatefulWidget {
  final int? compaginId;
  final String? compaignName;
  const MyLeadPage({super.key, required this.compaginId, this.compaignName});

  @override
  State<MyLeadPage> createState() => _MyLeadPageState();
}

class _MyLeadPageState extends State<MyLeadPage> {
  List data = [
    'Overview',
    'Views',
    'Likes',
    'Follows',
    // 'Blocks',
    // 'Ratings',
    // 'Page visits'
  ];

  DropDurationController dropGenderController =
      Get.put(DropDurationController());
  final OrdersController orderController =
      Get.put(OrdersController(), permanent: true);
  LeadController leadController = Get.put(LeadController());
  @override
  void initState() {
    super.initState();
    leadController.init(adId: widget.compaginId!);
    orderController.selectData.value = OrderListData(id: widget.compaginId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            leadController.selectedIndex.value = i;
                          });
                          // leadController.init();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: ShapeDecoration(
                            color: i == leadController.selectedIndex.value
                                ? const Color(0xFFBF180E)
                                : const Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                '${data[i]}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: i == leadController.selectedIndex.value
                                      ? Colors.white
                                      : const Color(0xFFBF180E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Obx(
                        () => TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: TextEditingController()
                            ..text =
                                orderController.selectData.value.campaignName ??
                                    widget.compaignName ??
                                    "",
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => const DropDownCampaign(),
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
                            border: InputBorder.none,
                            hintText: 'Select Campaign',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.only(top: 1, bottom: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Obx(
                        () => TextFormField(
                          style: const TextStyle(fontSize: 13),
                          controller: TextEditingController()
                            ..text = dropGenderController.selectData.value,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => const DropDownDuration(),
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Field can't be blank";
                            }

                            return null;
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select Duration',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                              ),
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: 18,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(
                height: 370,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: LineChartpage(),
                ),
              ),
              Text(
                dropGenderController.selectData.value == "Last 7 days"
                    ? "(in Days)"
                    : dropGenderController.selectData.value == "Current Year"
                        ? "(in Month)"
                        : dropGenderController.selectData.value == "Lifetime"
                            ? "(in Month)"
                            : dropGenderController.selectData.value ==
                                    "Yesterday"
                                ? "(in Hour)"
                                : dropGenderController.selectData.value ==
                                        "Today"
                                    ? "(in Hour)"
                                    : "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    leadController.selectedIndex.value == 1
                        ? 'Viewed profiles'
                        : leadController.selectedIndex.value == 2
                            ? 'Top Likes'
                            : leadController.selectedIndex.value == 3
                                ? "Follows"
                                : "",
                    style: const TextStyle(
                      color: Color(0xFF001E2F),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (leadController.selectedIndex.value != 0)
                    InkWell(
                      onTap: () {
                        leadController.selectedIndex.value == 1
                            ? Get.to(ViewAll(
                                isFollowUserData: leadController.isViewUserData,
                                name: "Viewed profiles"))
                            : leadController.selectedIndex.value == 2
                                ? Get.to(ViewAll(
                                    isFollowUserData:
                                        leadController.isLikeUserData,
                                    name: "Top Likes"))
                                : leadController.selectedIndex.value == 3
                                    ? Get.to(ViewAll(
                                        isFollowUserData:
                                            leadController.isFollowUserData,
                                        name: "Follows"))
                                    : "";
                      },
                      child: const Text(
                        'View all',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF261AAC),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 10),
              leadController.selectedIndex.value == 3
                  ? list(leadController.isFollowUserData)
                  : leadController.selectedIndex.value == 1
                      ? list(leadController.isViewUserData)
                      : leadController.selectedIndex.value == 2
                          ? list(leadController.isFollowUserData)
                          : Container(),
            ],
          ),
        ),
      ),
    );
  }

  header() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Analytics",
        style: GoogleFonts.poppins(
            color: AdtipColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16),
      ),
    );
  }
}
