import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drop_controller.dart';

class DropDownCompany extends StatefulWidget {
  const DropDownCompany({super.key});

  @override
  State<DropDownCompany> createState() => _DropDownCompanyState();
}

class _DropDownCompanyState extends State<DropDownCompany> {
  DropControllerCompany skipVideoController = Get.put(DropControllerCompany());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
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
                      itemCount: skipVideoController.companyListData.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                            onTap: () {
                              skipVideoController.setSelect(
                                  skipVideoController.companyListData[i]);
                            },
                            title: Text(
                                skipVideoController.companyListData[i].name ??
                                    ""),
                            trailing: Obx(
                              () => Visibility(
                                visible: skipVideoController.checkIsSelected(
                                    skipVideoController.companyListData[i]),
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
