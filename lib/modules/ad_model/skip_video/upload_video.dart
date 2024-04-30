import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../myCompanyPage/widgets/c_text_form_filed_underline.dart';
import '../page/checkout_screen.dart';
import 'skip_video_controller.dart';
import 'widget/widget.dart';

class UploadVideoSecondScreen extends StatefulWidget {
  final String? title;
  final int oderValue;
  final String campaign;
  final String des;
  final String location;
  final String gst;
  final String website;
  final String? link;
  final String name;
  const UploadVideoSecondScreen({
    super.key,
    required this.des,
    required this.location,
    required this.gst,
    required this.website,
    this.title,
    required this.oderValue,
    required this.campaign,
    this.link,
    required this.name,
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
  @override
  void initState() {
    super.initState();
    desController.text = widget.des;
    locationController.text = widget.location;
    gstController.text = widget.gst;
    linkController.text = widget.link ?? widget.website;
  }

  SkipVideoController skipVideoController =
      Get.put(SkipVideoController(), permanent: true);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("${widget.link}99999");

    return Scaffold(
      backgroundColor: AdtipColors.white,
      body: Center(
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                Get.to(CheckOutScreen(
                                  orderValue: widget.oderValue,
                                  des: desController.text,
                                  loc: locationController.text,
                                  website: linkController.text,
                                  campaign: widget.campaign,
                                  tax: gstController.text,
                                  name: widget.name,
                                ));
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
                      Get.back();
                    },
                    buttonColor: AdtipColors.white,
                    textColor: AdtipColors.black,
                    showImage: false,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
