import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drop_controller.dart';

class DropDownProf extends StatefulWidget {
  const DropDownProf({super.key});

  @override
  State<DropDownProf> createState() => _DropDownProfState();
}

class _DropDownProfState extends State<DropDownProf> {
  DropProfessController skipVideoController =
      Get.put(DropProfessController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: SizedBox(
          width: size.width * 0.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    skipVideoController.clickAll();
                  },
                  child: const Text("Select All     ",
                      style: TextStyle(color: Colors.blue, fontSize: 15))),
              Obx(
                () => skipVideoController.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            skipVideoController.professionListData.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                              onTap: () {
                                skipVideoController.addOrRemove(
                                    skipVideoController.professionListData[i]);
                              },
                              title: Text(skipVideoController
                                      .professionListData[i].name ??
                                  ""),
                              trailing: Obx(
                                () => Visibility(
                                  visible: skipVideoController.checkIsSelected(
                                      skipVideoController
                                          .professionListData[i]),
                                  replacement:
                                      const Icon(Icons.check_box_outline_blank),
                                  child: const Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  ),
                                ),
                              ));
                        }),
              ),
            ],
          ),
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
