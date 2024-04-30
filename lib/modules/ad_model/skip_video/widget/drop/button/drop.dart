import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drop_controller.dart';

class DropDownBotton extends StatefulWidget {
  const DropDownBotton({super.key});

  @override
  State<DropDownBotton> createState() => _DropDownBottonState();
}

class _DropDownBottonState extends State<DropDownBotton> {
  DropControllerBotton skipVideoController = Get.put(DropControllerBotton());

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
              Obx(
                () => skipVideoController.loading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: skipVideoController.buttonListData.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                              onTap: () {
                                skipVideoController.setSelect(
                                    skipVideoController.buttonListData[i]);
                              },
                              title: Text(
                                  skipVideoController.buttonListData[i].name ??
                                      ""),
                              trailing: Obx(
                                () => Visibility(
                                  visible: skipVideoController.checkIsSelected(
                                      skipVideoController.buttonListData[i]),
                                  replacement:
                                      Icon(Icons.check_box_outline_blank),
                                  child: Icon(
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
