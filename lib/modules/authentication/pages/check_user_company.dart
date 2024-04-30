import 'package:adtip_web_3/modules/authentication/controllers/login_controller.dart';
import 'package:adtip_web_3/modules/createCompany/page/create_company_page.dart';
import 'package:adtip_web_3/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUserCompanyExist extends StatefulWidget {
  const CheckUserCompanyExist({super.key});

  @override
  State<CheckUserCompanyExist> createState() => _CheckUserCompanyExistState();
}

class _CheckUserCompanyExistState extends State<CheckUserCompanyExist> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: loginController.checkCompanyExists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const DashboardPage();
              }
              return const CreateCompanyPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
