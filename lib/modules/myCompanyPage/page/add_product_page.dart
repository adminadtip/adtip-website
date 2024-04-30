import 'dart:convert';
import 'dart:io';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../../widgets/icon/c_icon_image.dart';
import '../../../widgets/text/loader.dart';
import '../controller/my_company_controller.dart';

class AddProductScreen extends StatefulWidget {
  final companyID;
  final data;
  final title;
  bool? isedit;
  final productid;

  AddProductScreen(
      {super.key,
      this.companyID,
      this.data,
      this.title,
      required this.isedit,
      this.productid});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _descriptionFieldController = TextEditingController();
  TextEditingController _brandNameFieldController = TextEditingController();
  TextEditingController _unitFieldController = TextEditingController();
  TextEditingController _regularPriceFieldController = TextEditingController();
  TextEditingController _marketPriceFieldController = TextEditingController();
  String? selectedDays = '7-8';
  int? selectedDeliveryType = 0;
  final controller = Get.put(MyCompanyController());

  List imageList = [];
  List categories = [];
  Map<String, dynamic>? selectedCategory = null;
  // ignore: prefer_typing_uninitialized_variables
  late final response;
  // Initialize a set to store selected sizes
  List<dynamic> selectedSizes = [];

  // List of available sizes
  List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];

  int userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

  void _removeImage(int index) {
    setState(() {
      imageList.removeAt(index);
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Handle the picked image, e.g., display it in an Image widget
        print('Image picked: ${pickedFile}');
        showLoaderDialog(context, Colors.blue);
        await uploadImagesAWS(pickedFile.path);
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  uploadImagesAWS(filepath) async {
    var myUrl = await Utils.uploadImageToAwsAmplify(
        path: filepath, folderName: 'Product Images');
    setState(() {
      imageList.add(myUrl);
    });
    // var myUrl = (await AwsS3.uploadFile(
    //       acl: ACL.bucket_owner_full_control,
    //       accessKey: "AKIAWOVUZ5ONNYTS5G7O",
    //       secretKey: "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",
    //       file: File(filepath?.path ?? ""),
    //       bucket: "adtipbucket",
    //       region: "ap-south-1",
    //       destDir: 'images',
    //     )) ??
    //     "";
    // print(myUrl);
    // setState(() {
    //   imageList.add(myUrl);
    // });
    // return myUrl;
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    if (widget.data != null) {
      Map<String, dynamic> dataMap = widget.data[0];
      _nameFieldController.text = dataMap['name'];
      _descriptionFieldController.text = dataMap['description'];
      _brandNameFieldController.text = dataMap['brand'];
      selectedDays = dataMap["delivery_time"];
      _unitFieldController.text = dataMap["units"].toString();
      _regularPriceFieldController.text = dataMap["regular_price"].toString();
      _marketPriceFieldController.text = dataMap["market_price"].toString();
      selectedSizes.addAll(dataMap["size"]);
      imageList.addAll(dataMap["images"]);
      print("=== $categories");
    }
  }

  void fetchCategories() async {
    response =
        await NetworkApiServices().getApi(UrlConstants.getproductCategary);

    setState(() {
      categories = response["data"];
      print("categ === $categories");
      if (widget.data != null) {
        Map<String, dynamic> dataMap = widget.data[0];
        List categoryName =
            getCategoryNameById(dataMap["category_id"], categories);
      }
    });
  }

  getCategoryNameById(int categoryId, List categoriess) {
    for (var category in categories) {
      if (category['id'] == categoryId) {
        setState(() {
          print("=== $category");
          selectedCategory = category;
          print("cat== $selectedCategory");
        });
      }
    }
  }

  Future<void> addProduct() async {
    Map data = {
      'name': _nameFieldController.text,
      'description': _descriptionFieldController.text,
      'brand': _brandNameFieldController.text,
      'categoryId': selectedCategory!["id"],
      'deliveryTime': selectedDays,
      'units': _unitFieldController.text,
      'regularPrice': _regularPriceFieldController.text,
      'marketPrice': _marketPriceFieldController.text,
      "size": selectedSizes,
      "images": imageList,
      "companyId": widget.companyID,
      "created_by": userId
    };
    await NetworkApiServices().postApi(data, UrlConstants.addproduct);
    print("resp=== ${response["status"]}");
    print(response["message"]);
  }

  editProduct() async {
    Map data = {
      'name': _nameFieldController.text,
      'description': _descriptionFieldController.text,
      'brand': _brandNameFieldController.text,
      'categoryId': selectedCategory!["id"],
      'deliveryTime': selectedDays,
      'units': _unitFieldController.text,
      'regularPrice': _regularPriceFieldController.text,
      'marketPrice': _marketPriceFieldController.text,
      "size": selectedSizes,
      "images": imageList,
      "companyId": widget.companyID,
      'id': widget.productid,
    };
    print(widget.isedit);

    response =
        await NetworkApiServices().postApi(data, UrlConstants.editproduct);
    print(response);
    print("resp=== ${response["status"]}");
    print(response["message"]);
  }

  Widget _buildImageList() {
    return SizedBox(
      height: 120,
      child: imageList.isEmpty
          ? _buildEmptyListView()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: imageList[index]?.split(',').first ?? "",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/noImage.jpg',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            _removeImage(index);
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 12,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            clipBehavior: Clip.antiAlias,
            color: Colors.grey[300],
            child: Container(
              width: 118,
              height: 84,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.image,
                size: 40,
                color: Colors.grey[600],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget deliveryType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Delivery Type',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 16),
        ListTile(
          leading: Image.asset(AdtipAssets.deliveryType1),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '6-7 days',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Basic',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              Text(
                'Not reccommded for s..',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: Radio(
            value: 0,
            groupValue: selectedDeliveryType,
            onChanged: (int? value) {
              setState(() {
                selectedDeliveryType = value;
              });
            },
          ),
        ),
        ListTile(
          leading: Image.asset(AdtipAssets.deliveryType2),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1-2 days',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'AdTip Delivery',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              Text(
                'Best customer satisfaction',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: Radio(
            value: 1,
            groupValue: selectedDeliveryType,
            onChanged: (int? value) {
              setState(() {
                selectedDeliveryType = value;
              });
            },
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: ListView(
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                    controller: _nameFieldController,
                    decoration: InputDecoration(
                        hintText: "Enter product name",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _nameFieldController.clear();
                            });
                          },
                        ))),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const SizedBox(height: 10),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                    maxLines: 3,
                    controller: _descriptionFieldController,
                    decoration: InputDecoration(
                        hintText: "Describe your product here",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _descriptionFieldController.clear();
                            });
                          },
                        ))),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const SizedBox(height: 10),
                const Text(
                  'Brand Name',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                    controller: _brandNameFieldController,
                    decoration: InputDecoration(
                        hintText: "Enter brand name",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _brandNameFieldController.clear();
                            });
                          },
                        ))),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 17),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    value: selectedCategory,
                    isExpanded: true,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        hintText: 'Category',
                        contentPadding: EdgeInsets.zero,
                        border: const UnderlineInputBorder()),
                    items: categories.map((category) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: category,
                        child: Text(
                          category['name'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                        print(selectedCategory!);
                      });
                    },
                    validator: (value) {
                      print(value);
                      if (value == null) {
                        return "Field can't be blank";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery time(days)',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(width: 20),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedDays,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDays = newValue;
                          });
                        },
                        items: <String>[
                          '7-8',
                          '1-2',
                          '2-3',
                          '3-4',
                          '4-5',
                          '5-6',
                          '6-7',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const SizedBox(height: 10),
                const Text(
                  'Units Available',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                    controller: _unitFieldController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter stock units count",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _unitFieldController.clear();
                            });
                          },
                        ))),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const SizedBox(height: 10),
                const Text(
                  'Size Options',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: sizes.length,
                    itemBuilder: (context, index) {
                      final size = sizes[index];
                      return CheckboxListTile(
                        title: Text(size),
                        value: selectedSizes.contains(size),
                        onChanged: (value) {
                          setState(() {
                            // Update the selected sizes when the checkbox is changed
                            if (value != null) {
                              if (value) {
                                selectedSizes.add(size);
                              } else {
                                selectedSizes.remove(size);
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const SizedBox(height: 10),
                const Text(
                  'Regular Price',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                    controller: _regularPriceFieldController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "₹",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _regularPriceFieldController.clear();
                            });
                          },
                        ))),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                const SizedBox(height: 10),
                const Text(
                  'Market Price',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                    controller: _marketPriceFieldController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "₹",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _marketPriceFieldController.clear();
                            });
                          },
                        ))),
                const Divider(
                  color: Colors.grey, // Set divider color
                  thickness: 0, // Set divider thickness
                ),
                deliveryType(),
                _buildImageList(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black,
                      ),
                      child: TextButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: const Text(
                          'Upload Images',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 60,
                  width: 335,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      print(selectedCategory);
                      if (_nameFieldController.text.isEmpty) {
                        Utils.showErrorMessage('Please enter name of product');
                      } else if (_descriptionFieldController.text.isEmpty) {
                        Utils.showErrorMessage('Please enter name of product');
                      } else if (selectedCategory == null) {
                        Utils.showErrorMessage('Please select category');
                      } else if (_unitFieldController.text.isEmpty) {
                        Utils.showErrorMessage('Please enter units');
                      } else if (_regularPriceFieldController.text.isEmpty ||
                          _marketPriceFieldController.text.isEmpty) {
                        Utils.showErrorMessage(
                            'please enter regular and market price');
                      } else if (int.parse(_regularPriceFieldController.text) <
                          int.parse(_marketPriceFieldController.text)) {
                        Utils.showErrorMessage(
                            'Regular price must be greater than market price');
                      } else if (imageList.length == 0) {
                        Utils.showErrorMessage('Please upload image');
                      } else {
                        if (widget.isedit == false) {
                          await addProduct();
                          await controller
                              .fetchCompanyProductList(widget.companyID!);
                          Navigator.of(context).pop();
                          Utils.showErrorMessage('Product added successfully.');
                        } else {
                          editProduct();
                          Navigator.of(context).pop();
                          Utils.showErrorMessage(
                              'Product updated successfully.');
                        }
                      }
                    },
                    child: Text(
                      widget.isedit == false ? 'Add Product' : "Save",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                widget.isedit == false
                    ? Container(
                        height: 60,
                        width: 315,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'No Thanks',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
