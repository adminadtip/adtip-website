import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/button/c_login_button.dart';
import '../controller/create_company_controller.dart';
import '../widget/appbar_widget.dart';

class AddButtonPage extends StatefulWidget {
  const AddButtonPage({super.key});

  @override
  State<AddButtonPage> createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  late int selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  void setSelectedRadio(int? val) {
    setState(() {
      selectedRadio = val ?? 0;
    });
  }

  List<String> radioButtonList = [
    "Book Now",
    "Visit Page",
    "Know More",
    "Buy Now",
    "Reserve"
  ];

  final controller = Get.put(CreateCompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/images/backdrop.png',
              )),
        ),
        child: Center(
          child: SizedBox(
            height: 711,
            width: 472,
            child: Column(
              children: [
                Image.asset('assets/images/adtip_icon.png'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create Company Page',
                        style: GoogleFonts.inter(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Make your Company/Business visible to the users. The best advertising platform.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: radioButtonList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffE4EAFF)),
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    radioButtonList[index],
                                    style: GoogleFonts.roboto(
                                        color: Colors.grey.shade400),
                                  ),
                                  Radio(
                                    value: index + 1,
                                    groupValue: selectedRadio,
                                    activeColor: Colors.green,
                                    onChanged: (val) {
                                      print("Radio $val");
                                      setSelectedRadio(val);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: CLoginButton(
                            title: 'Save',
                            buttonColor: const Color(0xFF01A4AF),
                            textColor: Colors.white,
                            showImage: false,
                            isLoading: false,
                            onTap: () {
                              /* Get.to(()=>const CompanyPage()); */
                              controller.buttonSelected.value =
                                  radioButtonList[selectedRadio - 1];
                              controller.userCompanyProfile.buttonType =
                                  radioButtonList[selectedRadio - 1];
                              Navigator.of(context).pop();
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                'Back',
                                style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
