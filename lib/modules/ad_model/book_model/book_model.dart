// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../myCompanyPage/widgets/c_text_form_filed_underline.dart';
import '../controllers/ad_models_controller.dart';
import '../skip_video/widget/widget.dart';

class BookModelsScreen extends StatefulWidget {
  const BookModelsScreen({super.key});

  @override
  State<BookModelsScreen> createState() => _BookModelsScreenState();
}

class _BookModelsScreenState extends State<BookModelsScreen> {
  TextEditingController startController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AdModelsController adModelsController = Get.put(AdModelsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Image.asset(
              'assets/images/icon.png',
              color: AdtipColors.black,
            ),
          )
        ],
        title: const Text(
          "Book Demo Ad",
          style: TextStyle(
              color: AdtipColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CTextFormFiledUnderline(
                      controller: nameController,
                      style: customStyle(),
                      title: 'Ad name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field can't be blank";
                        }
                        return null;
                      },
                      hintText: 'Enter ad name'),
                  CTextFormFiledUnderline(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      style: customStyle(),
                      title: 'Phone number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field can't be blank";
                        }
                        if (phoneController.text.length != 10) {
                          return "phone number invalid";
                        }
                        return null;
                      },
                      hintText: 'Enter phone number'),
                  CTextFormFiledUnderline(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field can't be blank";
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        if (!emailValid) {
                          return "Email invalid";
                        }

                        return null;
                      },
                      style: customStyle(),
                      title: 'Mail',
                      hintText: 'Enter mail id'),
                  Text(
                    "Enter the start date & time for ad demo (30 min)",
                    style: customStyle(),
                  ),
                  TextFormField(
                    controller: startController,
                    onTap: () {
                      _showFromDateTimePickerStart();
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                        hintText: 'Start Date & Time',
                        suffixIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  Obx(
                    () => CLoginButton(
                      isLoading: adModelsController.loadingDemo.value,
                      title: 'Book Demo',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          adModelsController.requestDemo(
                            name: nameController.text,
                            emailId: emailController.text,
                            phone: phoneController.text,
                            startDate: startController.text.substring(0, 10),
                            startTime: startController.text.substring(11, 16),
                          );
                        }
                      },
                      buttonColor: AdtipColors.black,
                      textColor: AdtipColors.white,
                      showImage: false,
                    ),
                  ),
                  CLoginButton(
                    title: 'Cancel',
                    onTap: () {
                      Get.back();
                    },
                    buttonColor: AdtipColors.white,
                    textColor: AdtipColors.black,
                    showImage: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showFromDateTimePickerStart() async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (datePicked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dialOnly,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (timePicked != null) {
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(timePicked,
            alwaysUse24HourFormat: true);

        setState(() {
          startController.text =
              "${DateFormat("yyyy-MM-dd").format(datePicked)} $formattedTimeOfDay";
        });
      }
    }
  }
}
