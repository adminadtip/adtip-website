import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/qr_ad_controller.dart';

class QrAdWebData extends StatefulWidget {
  final int adId;
  const QrAdWebData({super.key, required this.adId});

  @override
  State<QrAdWebData> createState() => _QrAdWebDataState();
}

class _QrAdWebDataState extends State<QrAdWebData> {
  final qrAdWebDataController = Get.put(QrCodeAdDisplayController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qrAdWebDataController.getQrWebData(adId: widget.adId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Qr Web Data'),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: Get.width,
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 100, child: Text('S.No.')),
                  SizedBox(width: 100, child: Text('Name')),
                  SizedBox(width: 100, child: Text('Mobile Number')),
                  SizedBox(width: 100, child: Text('profession')),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => qrAdWebDataController.loadingQrAdWebData.value
                ? const Center(child: CircularProgressIndicator())
                : qrAdWebDataController.qrAdWebModel!.data.isEmpty
                    ? const Center(
                        child: Text('No data found'),
                      )
                    : Expanded(
                        child: SizedBox(
                          width: Get.width,
                          child: ListView.builder(
                            itemCount:
                                qrAdWebDataController.qrAdWebModel!.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final qrAdWeb = qrAdWebDataController
                                  .qrAdWebModel!.data[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        child: Text('${index + 1}')),
                                    SizedBox(
                                        width: 100,
                                        child: SelectableText(
                                            '${qrAdWeb.userName}')),
                                    SizedBox(
                                        width: 100,
                                        child: SelectableText(
                                            '${qrAdWeb.mobileNumber}')),
                                    SizedBox(
                                        width: 100,
                                        child:
                                            SelectableText(qrAdWeb.profession)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
