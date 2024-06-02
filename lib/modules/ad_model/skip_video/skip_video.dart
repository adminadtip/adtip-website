import 'dart:convert';

import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/ad_model/controllers/ad_models_controller.dart';
import 'package:adtip_web_3/modules/ad_model/skip_video/widget/drop/display_ad/controller.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import '../../../helpers/constants/colors.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../createCompany/page/create_company_page.dart';
import '../../myCompanyPage/model/profession_list.dart';
import '../../myCompanyPage/widgets/c_text_form_filed_underline.dart';
import '../widgets/search_location.dart';
import 'skip_video_controller.dart';
import 'skip_video_second.dart';
import 'widget/drop/button/drop_controller.dart';
import 'widget/drop/company/drop_controller.dart';
import 'widget/drop/gender/controller.dart';
import 'widget/drop/gender/gender_drop.dart';
import 'widget/drop/marital/controller.dart';
import 'widget/drop/marital/maritial_drop.dart';
import 'widget/drop/proffession/drop.dart';
import 'widget/drop/proffession/drop_controller.dart';
import 'widget/widget.dart';
import 'package:http/http.dart' as http;

class SkipVideoScreen extends StatefulWidget {
  // final String? title;
  // final int viewPrice;
  // final String? modelId;
  // final String? mediaType;
  // final String? link;
  const SkipVideoScreen({
    super.key,
    // this.title,
    // this.modelId,
    // this.mediaType,
    // required this.link,
    // required this.viewPrice
  });

  @override
  State<SkipVideoScreen> createState() => _SkipVideoScreenState();
}

class _SkipVideoScreenState extends State<SkipVideoScreen>
    with SingleTickerProviderStateMixin {
  SkipVideoController skipVideoController =
      Get.put(SkipVideoController(), permanent: true);
  DropProfessController dropProfessController =
      Get.put(DropProfessController(), permanent: true);
  DropGenderController dropGenderController = Get.put(DropGenderController());
  DropMaritalController dropMaritialController =
      Get.put(DropMaritalController());
  DropControllerBotton dropControllerBottom = Get.put(DropControllerBotton());
  DropDisplayAdController dropDisplayAdController =
      Get.put(DropDisplayAdController());
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController startNowController = TextEditingController();
  final adModelController = Get.put(AdModelsController());
  List selectedAreasList = [];
  List selectedAreas = [];
  void _onPlaceSelected(Map<String, dynamic> location) {
    print('Selected Location: $location');
    setState(() {
      selectedAreasList.add(location['name'].split(',').first ?? "");
      selectedAreas.add(location);
      print('selected reas $selectedAreas');
      mapController.clear();
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    dropProfessController.getProfessionList();
    skipVideoController.getCompanyList();
    skipVideoController.lastFillData.clear();
    dropProfessController.selectedList.clear();
    _counterPay = adModelController.viewPrice.value;
  }

  int? adPerViewPercentage;
  String? des;
  String? location;
  String? gst;
  String? website;

  DateTime now = DateTime.now();

  List<String> companyList = ['Create company page'];
  List<String> defaultList = ['FunTube'];

  RangeValues _currentRangeValues = const RangeValues(0, 100);
  late final TabController _tabController;
  TextEditingController perCustomerWatchController = TextEditingController();

  TextEditingController payPerCustomerController = TextEditingController();
  TextEditingController targetPerController = TextEditingController();

  String? selectedValue;
  int _counter = 1;
  void _remove() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  void _add() {
    setState(() {
      _counter++;
    });
  }

  late int _counterPay;
  void _removePay() {
    setState(() {
      if (_counterPay > adModelController.viewPrice.value) {
        _counterPay--;
      }
    });
  }

  void _addPay() {
    setState(() {
      _counterPay++;
    });
  }

  int _counterDay = 1;
  void _removeDay() {
    setState(() {
      if (_counterDay > 1) {
        _counterDay--;
      }
    });
  }

  void _addDay() {
    setState(() {
      _counterDay++;
    });
  }

  List<DropdownMenuItem> items = [];
  DateTime? startTime;
  int totalDays = 0;
  String? companyName;
  int? companyId;
  final _formKey = GlobalKey<FormState>();
  TextEditingController campaignController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  DropControllerCompany dropControllerCompany =
      Get.put(DropControllerCompany());
  final dashboardController = DashboardController();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: Obx(
            () {
              if (skipVideoController.loading.value) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: CircularProgressIndicator(),
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adModelController.title.value,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Target Company", style: customStyle()),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      isExpanded: true,
                      decoration: InputDecoration(
                          hintStyle: customStyle(color: Colors.grey.shade600),
                          hintText: '   Target company',
                          contentPadding: EdgeInsets.zero,
                          border: const UnderlineInputBorder()),
                      items: [
                        ...skipVideoController.companyListData.map((value) {
                          return DropdownMenuItem(
                            onTap: () async {
                              print('company id main ${value.id}');
                              companyName = value.name;
                              companyId = value.id;

                              // await skipVideoController
                              //     .getLastDataFill(companyId ?? 0);
                              // if (skipVideoController.lastFillData.isNotEmpty) {
                              //   await init();
                              // } else {
                              //   skipVideoController.lastFillData.clear();
                              // }
                              // setState(() {});
                            },
                            value: value,
                            child: Text(value.name ?? "", style: customStyle()),
                          );
                        }).toList(),
                        ...defaultList.map((String value) {
                          return DropdownMenuItem(
                            onTap: () {
                              companyName = value;
                            },
                            value: value,
                            child: Text(value, style: customStyle()),
                          );
                        }).toList(),
                        ...companyList.map((String value) {
                          return DropdownMenuItem(
                            onTap: () {
                              setState(() {
                                companyName = null;
                              });
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                Get.to(const CreateCompanyPage());
                              });
                            },
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {},
                      validator: (value) {
                        print(value);
                        if (value == null) {
                          return "Field can't be blank";
                        }
                        if (value == 'Create company page') {
                          return 'Create company page';
                        }
                        return null;
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black45,
                          size: 27,
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  CTextFormFiledUnderline(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field can't be blank";
                        }
                        return null;
                      },
                      style: customStyle(),
                      controller: campaignController,
                      title: 'Campaign Name',
                      hintText: 'Enter Campaign name'),
                  Text("Target Gender", style: customStyle()),
                  TextFormField(
                    controller: TextEditingController()
                      ..text = dropGenderController.selectedList.join(','),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const DropDownGender(),
                      );
                    },
                    validator: (value) {
                      print(value);
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      }

                      return null;
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Target gender',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )),
                  ),

                  const SizedBox(height: 20),
                  Text("Target Marital Status", style: customStyle()),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      }

                      return null;
                    },
                    controller: TextEditingController()
                      ..text = dropMaritialController.selectedList.join(','),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const DropDownMaritial(),
                      );
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Target marital status',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Text('Target age', style: customStyle()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_currentRangeValues.start.round().toString(),
                          style: customStyle()),
                      SizedBox(
                        width: 270,
                        child: RangeSlider(
                          divisions: 100,
                          activeColor: Colors.blue,
                          values: _currentRangeValues,
                          onChangeStart: (value) {},
                          min: 0,
                          max: 100,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                      ),
                      Text(
                        _currentRangeValues.end.round().toString(),
                        style: customStyle(),
                      ),
                    ],
                  ),
                  Text('Target Profession', style: customStyle()),
                  TextFormField(
                    validator: (value) {
                      print(value);
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      }
                      if (dropProfessController.selectedList.isEmpty) {
                        return "Field can't be blank";
                      }

                      return null;
                    },
                    controller: TextEditingController()
                      ..text =
                          "${dropProfessController.selectedList.length} profession selected",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DropDownProf(),
                      );
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Target Profession',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )),
                  ),

                  const SizedBox(height: 15),
                  Text('Target Areas', style: customStyle()),
                  Wrap(
                      spacing: 6.0,
                      children: List.generate(selectedAreasList.length, (i) {
                        return InputChip(
                          padding: const EdgeInsets.all(2.0),
                          label:
                              Text(selectedAreasList[i], style: customStyle()),
                          onDeleted: () {
                            setState(() {
                              selectedAreasList.removeAt(i);
                              selectedAreas.removeAt(i);
                            });
                          },
                        );
                      })),
                  PlacesSearchWidget(
                    onPlaceSelected: _onPlaceSelected,
                    searchController: mapController,
                  ),

                  // GooglePlaceAutoCompleteTextField(
                  //   textEditingController: mapController,
                  //   boxDecoration: const BoxDecoration(
                  //       border: Border(bottom: BorderSide())),
                  //   googleAPIKey: "AIzaSyC7-UF5ZiyFhW1nYYLdVTWf8740vAfg0fc",
                  //   inputDecoration: const InputDecoration(
                  //       hintText: 'Search areas',
                  //       isDense: true,
                  //       border: InputBorder.none),
                  //   itemClick: (prediction) {
                  //     print('lat long ${prediction.lng}');
                  //     setState(() {
                  //       selectedAreasList.add(
                  //           prediction.description?.split(',').first ?? "");
                  //       mapController.clear();
                  //     });
                  //   },
                  //   itemBuilder: (context, index, Prediction prediction) {
                  //     return Container(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Row(
                  //         children: [
                  //           const Icon(Icons.location_on),
                  //           const SizedBox(
                  //             width: 7,
                  //           ),
                  //           Expanded(child: Text(prediction.description ?? ""))
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   isCrossBtnShown: false,
                  //   seperatedBuilder: Divider(),
                  // ),
                  const SizedBox(height: 20),
                  Text('How many times customers watch ad per day?',
                      style: customStyle()),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: perCustomerWatchController,
                    // ..text = _counter.toString(),
                    onChanged: (val) {
                      setState(() {});
                      // if (int.parse(val) >= 1) {
                      //   setState(() {
                      //     _counter = int.parse(val);
                      //   });
                      // }
                      // if (val.isNotEmpty) {
                      //   final intVal = int.tryParse(val);
                      //   if (intVal != null && intVal >= 1) {
                      //     setState(() {
                      //       _counter = intVal;
                      //     });
                      //   }
                      // }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      } else if (value == "0") {
                        return "0 can't be taken";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Container(
                        width: 90,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        // child: Container(
                        //   height: 30,
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.grey),
                        //       borderRadius: BorderRadius.circular(7)),
                        //   child: Row(
                        //     children: [
                        //       const SizedBox(width: 5),
                        //       InkWell(
                        //           radius: 50,
                        //           customBorder: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(50)),
                        //           splashColor:
                        //               const Color.fromRGBO(52, 209, 191, 1),
                        //           onTap: _remove,
                        //           child: const Icon(Icons.remove)),
                        //       const SizedBox(width: 5),
                        //       Text(_counter.toString()),
                        //       const SizedBox(width: 5),
                        //       InkWell(
                        //           radius: 50,
                        //           customBorder: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(50)),
                        //           splashColor:
                        //               const Color.fromRGBO(52, 209, 191, 1),
                        //           onTap: _add,
                        //           child: const Icon(Icons.add)),
                        //       const SizedBox(width: 5),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'How much amount do you want to pay per customer?',
                    style: customStyle(),
                  ),
                  // Obx(() {
                  // payPerCustomerController.text =
                  //     adModelController.viewPrice.value.toString();
                  //return
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    controller: payPerCustomerController,
                    // ..text = _counterPay.toString(),
                    onChanged: (val) {
                      Future.delayed(const Duration(seconds: 1), () {
                        if (int.parse(val) <=
                            adModelController.viewPrice.value) {
                          Utils.showErrorMessage(
                              'Price cannot be less than \u{20B9} ${adModelController.viewPrice.value}');
                          payPerCustomerController.text =
                              adModelController.viewPrice.value.toString();
                          setState(() {});
                        } else {
                          payPerCustomerController.text = val;
                          setState(() {});
                        }
                      });

                      // if (int.parse(val) >= adModelController.viewPrice.value) {
                      //   setState(() {
                      //     _counterPay = int.parse(val);
                      //   });
                      // } else {
                      //   payPerCustomerController.clear();
                      // }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      } else if (value == "0") {
                        return "0 can't be taken";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefix: Text('\u{20B9} '),
                    ),
                  ),
                  // }),

                  const SizedBox(height: 10),
                  Text('How many customer target per day?',
                      style: customStyle()),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: targetPerController,
                    // ..text = _counterDay.toString(),
                    onChanged: (val) {
                      setState(() {});
                      // setState(() {
                      //   _counterDay = int.parse(val);
                      //});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      } else if (value == '0') {
                        return "0 can't be taken";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Container(
                        width: 90,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        // child: Container(
                        //   height: 30,
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.grey),
                        //       borderRadius: BorderRadius.circular(7)),
                        //   child: Row(
                        //     children: [
                        //       const SizedBox(width: 5),
                        //       InkWell(
                        //           radius: 50,
                        //           customBorder: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(50)),
                        //           splashColor:
                        //               const Color.fromRGBO(52, 209, 191, 1),
                        //           onTap: _removeDay,
                        //           child: const Icon(Icons.remove)),
                        //       const SizedBox(width: 5),
                        //       Text(_counterDay.toString()),
                        //       const SizedBox(width: 5),
                        //       InkWell(
                        //           radius: 50,
                        //           customBorder: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(50)),
                        //           splashColor:
                        //               const Color.fromRGBO(52, 209, 191, 1),
                        //           onTap: _addDay,
                        //           child: const Icon(Icons.add)),
                        //       const SizedBox(width: 5),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('How much amount do you want to spend per day?',
                      style: customStyle()),
                  const SizedBox(height: 4),

                  // Obx(() {
                  //   payPerCustomerController.text =
                  //       adModelController.viewPrice.value.toString();
                  //   return
                  Text(
                    '\u{20B9} ${(int.tryParse(perCustomerWatchController.text) ?? 0) * (int.tryParse(payPerCustomerController.text) ?? 0) * (int.tryParse(targetPerController.text) ?? 0)}.0',
                  ),
                  // }),

                  const Divider(),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 175,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: TabBar(
                              onTap: (tap) {
                                endController.clear();
                              },
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              splashBorderRadius: BorderRadius.circular(8),
                              controller: _tabController,
                              tabs: const [
                                Tab(
                                  icon: Text(
                                    "Now",
                                    style: TextStyle(
                                        fontSize: 16, color: AdtipColors.black),
                                  ),
                                ),
                                Tab(
                                  icon: Text(
                                    "Schedule",
                                    style: TextStyle(
                                        fontSize: 16, color: AdtipColors.black),
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                              Column(
                                children: [
                                  TextFormField(
                                    controller: startNowController
                                      ..text =
                                          "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: endController,
                                    onTap: () {
                                      _showFromDateTimePickerEnd();
                                    },
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                        hintText: 'End Date & Time',
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
                                ],
                              ),
                              Column(
                                children: [
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
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: endController,
                                    onTap: () {
                                      _showFromDateTimePickerEnd();
                                      // dateTimePickerend(context);
                                    },
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                        hintText: 'End Date & Time',
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
                                ],
                              ),
                            ])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Estimated Amount', style: customStyle()),

                  // Obx(() {
                  //   payPerCustomerController.text =
                  //       adModelController.viewPrice.value.toString();
                  //   return
                  Text(
                    '\u{20B9} ${(int.tryParse(perCustomerWatchController.text) ?? 0) * (int.tryParse(payPerCustomerController.text) ?? 0) * (int.tryParse(targetPerController.text) ?? 0) * totalDays}.0',
                  ),
                  // }),

                  // Text(
                  //     '\u{20B9} ${_counter * _counterDay * _counterPay * totalDays}.0',
                  //     style: customStyle()),
                  const Divider(),
                  const SizedBox(height: 20),
                  Obx(
                    () => skipVideoController.loadingFirst.value
                        ? const Center(child: CircularProgressIndicator())
                        : CLoginButton(
                            title: 'Next',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if (_currentRangeValues.start.round() != 0 &&
                                    _currentRangeValues.end.round() != 100) {
                                  skipVideoController.saveFirstPageAdModel(
                                      companyName: companyName,
                                      companyId: companyId.toString(),
                                      campaignName: campaignController.text,
                                      targetGender: dropGenderController
                                          .selectedList
                                          .join(',')
                                          .toString(),
                                      maritalStatus: dropMaritialController
                                          .selectedList
                                          .join(',')
                                          .toString(),
                                      targetLowerAge: _currentRangeValues.start
                                          .round()
                                          .toString(),
                                      targetUpperAge: _currentRangeValues.end
                                          .round()
                                          .toString(),
                                      targetProfessions: dropProfessController
                                          .selectedList
                                          .join(',')
                                          .toString(),
                                      targetArea: selectedAreas.toString(),
                                      adwatchPerDay:
                                          perCustomerWatchController.text,
                                      adPerdayPay:
                                          payPerCustomerController.text,
                                      adCustomerTargetPerDay:
                                          targetPerController.text,
                                      adSpendPerDay:
                                          "${(int.tryParse(perCustomerWatchController.text) ?? 0) * (int.tryParse(payPerCustomerController.text) ?? 0) * (int.tryParse(targetPerController.text) ?? 0)}",
                                      adModelId:
                                          adModelController.modelId.value,
                                      adStartDate: startNowController.text
                                          .substring(0, 10),
                                      adTime: startNowController.text
                                          .substring(11, 16),
                                      adEndDate:
                                          endController.text.substring(0, 10),
                                      adEndTime:
                                          endController.text.substring(11, 16),
                                      createdby: LocalPrefs()
                                          .getIntegerPref(
                                              key: SharedPreferenceKey.UserId)
                                          .toString(),
                                      onSuccess: () {
                                        adModelController.compaignName.value =
                                            campaignController.text;
                                        adModelController
                                            .adValue.value = (int.tryParse(
                                                    perCustomerWatchController
                                                        .text) ??
                                                0) *
                                            (int.tryParse(
                                                    payPerCustomerController
                                                        .text) ??
                                                0) *
                                            (int.tryParse(
                                                    targetPerController.text) ??
                                                0) *
                                            totalDays;
                                      });

                                  // name: campaignController.text.tost,
                                } else {
                                  Get.snackbar('Select target age', '',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                }
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
                      if (kDebugMode) {
                        print('button pressed');
                      }
                      skipVideoController.changeWidget();
                      //dashboardController.changeWidget(value: 1);
                      if (kDebugMode) {
                        print(
                            'button pressed ${dashboardController.selected.value}');
                      }
                    },
                    buttonColor: AdtipColors.white,
                    textColor: AdtipColors.black,
                    showImage: false,
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
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
          startTime = datePicked;
        });
      }
    }
  }

  Future<void> _showFromDateTimePickerEnd() async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now().add(const Duration(days: 1)),
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
        endController.text =
            "${DateFormat("yyyy-MM-dd").format(datePicked)} $formattedTimeOfDay";
        totalDays = datePicked
            .difference(startTime ?? DateTime(now.year, now.month, now.day))
            .inDays;

        setState(() {});
      }
    }
  }
}
