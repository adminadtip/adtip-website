import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'drop_controller.dart';

class DropDownBottons extends StatefulWidget {
  const DropDownBottons({super.key});

  @override
  State<DropDownBottons> createState() => _DropDownBottonsState();
}

class _DropDownBottonsState extends State<DropDownBottons> {
  DropControllerBottons skipVideoController = Get.put(DropControllerBottons());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              Obx(
                () => skipVideoController.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 300,
                        width: 400,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                skipVideoController.buttonListData.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                  onTap: () {
                                    skipVideoController.setSelect(
                                        skipVideoController.buttonListData[i]);
                                  },
                                  title: Text(skipVideoController
                                          .buttonListData[i].name ??
                                      ""),
                                  trailing: Obx(
                                    () => Visibility(
                                      visible: skipVideoController
                                          .checkIsSelected(skipVideoController
                                              .buttonListData[i]),
                                      replacement: const Icon(
                                          Icons.check_box_outline_blank),
                                      child: const Icon(
                                        Icons.check_box,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ));
                            }),
                      ),
              ),
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
      ),
    );
  }
}
