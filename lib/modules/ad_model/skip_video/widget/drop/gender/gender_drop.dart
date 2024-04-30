import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DropDownGender extends StatefulWidget {
  const DropDownGender({super.key});

  @override
  State<DropDownGender> createState() => _DropDownGenderState();
}

class _DropDownGenderState extends State<DropDownGender> {
  DropGenderController dropGenderController = Get.put(DropGenderController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: SizedBox(
          width: size.width * 0.1,
          // height: size.height * 0.1,
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
                  itemCount: dropGenderController.genderList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        onTap: () {
                          dropGenderController
                              .addOrRemove(dropGenderController.genderList[i]);
                        },
                        title: Text(dropGenderController.genderList[i]),
                        trailing: Obx(
                          () => Visibility(
                            visible: dropGenderController.checkIsSelected(
                                dropGenderController.genderList[i]),
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
