import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../../widgets/text/c_title_text.dart';
import '../widget/appbar_widget.dart';
import 'create_company_page.dart';

class YourAdDirectlyToCustomerPage extends StatefulWidget {
  const YourAdDirectlyToCustomerPage({super.key});

  @override
  State<YourAdDirectlyToCustomerPage> createState() =>
      _YourAdDirectlyToCustomerPageState();
}

class _YourAdDirectlyToCustomerPageState
    extends State<YourAdDirectlyToCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FF),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Image.asset(
                  AdtipAssets.CREATE_COMPANT_IMAGE,
                  height: 315,
                  width: 315,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your Ad directly to \n Customers',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 27, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                const CSubTitleText(
                    subTitle:
                        'Make your Company/Business visible to the users. The best advertising platform.',
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 20,
                ),
                nextButton(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: AdtipColors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Not Now',
                          style: GoogleFonts.inter(
                              color: AdtipColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
// App bar
//

  nextButton() {
    return CLoginButton(
        title: 'Create Company Page',
        buttonColor: AdtipColors.black,
        textColor: AdtipColors.white,
        showImage: false,
        onTap: () {
          Get.to(() => const CreateCompanyPage());
        });
  }
}
