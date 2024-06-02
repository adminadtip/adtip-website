import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lead_controller.dart';
import 'controller.dart';

class DropDownDuration extends StatefulWidget {
  const DropDownDuration({super.key});

  @override
  State<DropDownDuration> createState() => _DropDownDurationState();
}

class _DropDownDurationState extends State<DropDownDuration> {
  DropDurationController skipVideoController =
      Get.put(DropDurationController());
  LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: skipVideoController.genderList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      onTap: () {
                        skipVideoController
                            .setSelect(skipVideoController.genderList[i]);
                      },
                      title: Text(skipVideoController.genderList[i]),
                      trailing: Obx(
                        () => Visibility(
                          visible: skipVideoController.checkIsSelected(
                              skipVideoController.genderList[i]),
                          replacement:
                              const Icon(Icons.check_box_outline_blank),
                          child: const Icon(
                            Icons.check_box,
                            color: Colors.blue,
                          ),
                        ),
                      ));
                }),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                leadController.init();

                Navigator.of(context).pop();
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            )
          ],
        )
      ],
    );
  }
}
