import 'package:adtip_web_3/modules/ad_model/controllers/ad_models_controller.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../myCompanyPage/widgets/c_text_form_filed_underline.dart';
import '../page/checkout_screen.dart';
import 'skip_video_controller.dart';
import 'widget/widget.dart';

class UploadVideoSecondScreen extends StatefulWidget {
  const UploadVideoSecondScreen({
    super.key,
  });

  @override
  State<UploadVideoSecondScreen> createState() =>
      _UploadVideoSecondScreenState();
}

class _UploadVideoSecondScreenState extends State<UploadVideoSecondScreen> {
  TextEditingController desController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final admodelController = Get.put(AdModelsController());
  final dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    linkController.text = admodelController.promoteLink.value;
  }

  SkipVideoController skipVideoController =
      Get.put(SkipVideoController(), permanent: true);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                admodelController.title.value,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              CTextFormFiledUnderline(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field can't be blank";
                    }
                    return null;
                  },
                  maxLines: 3,
                  style: customStyle(),
                  controller: desController,
                  title: 'Description',
                  hintText: '\nDescribe your ad here'),
              CTextFormFiledUnderline(
                style: customStyle(),
                controller: locationController,
                title: 'Company Location',
                hintText: 'Enter company location',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can't be blank";
                  }
                  return null;
                },
              ),
              CTextFormFiledUnderline(
                  style: customStyle(),
                  controller: gstController,
                  title: 'Tax number/GST number (Optional)',
                  hintText: 'Enter tax number/GST number'),
              CTextFormFiledUnderline(
                  style: customStyle(),
                  controller: linkController,
                  title: 'Website link',
                  hintText: 'Enter website link (Optional)'),
              const SizedBox(height: 40),
              Obx(
                () => skipVideoController.loadingThird.value
                    ? const Center(child: CircularProgressIndicator())
                    : CLoginButton(
                        title: 'Next',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            dashboardController.changeWidget(value: 15);
                            admodelController.description.value =
                                desController.text;
                            admodelController.location.value =
                                locationController.text;
                            admodelController.website.value =
                                linkController.text;
                            admodelController.tax.value = gstController.text;
                            dashboardController.changeWidget(value: 15);
                          }
                        },
                        buttonColor: AdtipColors.black,
                        textColor: AdtipColors.white,
                        showImage: false,
                      ),
              ),
              CLoginButton(
                title: 'Back',
                onTap: () {
                  dashboardController.changeWidget(value: 13);
                },
                buttonColor: AdtipColors.white,
                textColor: AdtipColors.black,
                showImage: false,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
