import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DropDownDisplayAd extends StatefulWidget {
  const DropDownDisplayAd({super.key});

  @override
  State<DropDownDisplayAd> createState() => _DropDownDisplayAdState();
}

class _DropDownDisplayAdState extends State<DropDownDisplayAd> {
  DropDisplayAdController dropGenderController =
      Get.put(DropDisplayAdController());

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
              SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    dropGenderController.clickAll();
                  },
                  child: Text("Select All     ",
                      style: TextStyle(color: Colors.blue, fontSize: 15))),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dropGenderController.menuPlatform.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        onTap: () {
                          dropGenderController.addOrRemove(
                              dropGenderController.menuPlatform[i]);
                        },
                        title: Text(dropGenderController.menuPlatform[i]),
                        trailing: Obx(
                          () => Visibility(
                            visible: dropGenderController.checkIsSelected(
                                dropGenderController.menuPlatform[i]),
                            replacement: Icon(Icons.check_box_outline_blank),
                            child: Icon(
                              Icons.check_box,
                              color: Colors.blue,
                            ),
                          ),
                        ));
                  }),
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
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
            SizedBox(width: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
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
