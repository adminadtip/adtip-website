import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/order_controller.dart';
import '../lead_controller.dart';

class DropDownCampaign extends StatefulWidget {
  const DropDownCampaign({super.key});

  @override
  State<DropDownCampaign> createState() => _DropDownCampaignState();
}

class _DropDownCampaignState extends State<DropDownCampaign> {
  final OrdersController orderController = Get.put(OrdersController());
  @override
  void initState() {
    super.initState();
    orderController.getOrderList();
  }

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
            Obx(
              () => orderController.loading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orderController.orderListData.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                            onTap: () {
                              orderController
                                  .setSelect(orderController.orderListData[i]);
                            },
                            title: Text(
                                orderController.orderListData[i].campaignName ??
                                    ""),
                            trailing: Obx(
                              () => Visibility(
                                visible: orderController.checkIsSelected(
                                    orderController.orderListData[i]),
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
