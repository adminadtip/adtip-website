import 'dart:io';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';
import '../../../helpers/utils/utils.dart';
import '../../../widgets/button/c_login_button.dart';
import '../../../widgets/icon/c_icon_image.dart';
import '../../../widgets/text/loader.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../controller/post_controller.dart';
import '../widgets/c_text_form_filed_underline.dart';
import 'widget/button/drop.dart';
import 'widget/button/drop_controller.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  List imageList = [];
  TextEditingController displayC = TextEditingController();
  TextEditingController postNameC = TextEditingController();
  TextEditingController postDesC = TextEditingController();
  TextEditingController websiteC = TextEditingController();
  final companyController = Get.put(CreateCompanyController());

  DropControllerBottons dropControllerBottom = Get.put(DropControllerBottons());
  final PostController postController = Get.put(PostController());
  final dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    dropControllerBottom.getButtonList();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CTextFormFiledUnderline(
                    controller: postNameC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be blank";
                      }
                      return null;
                    },
                    title: 'Name',
                    hintText: 'Enter post name'),
                CTextFormFiledUnderline(
                    controller: postDesC,
                    title: 'Description(optional)',
                    hintText: 'Describe your post here'),
                CTextFormFiledUnderline(
                    controller: websiteC,
                    title: 'Website Link (Optional)',
                    hintText: 'Enter Website Link'),
                const Text('Target button to displays',
                    style: TextStyle(fontSize: 14)),
                Obx(
                  () => TextFormField(
                    controller: displayC
                      ..text = dropControllerBottom.selectData.value.name ?? "",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const DropDownBottons(),
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
                        hintText: 'Target button to display',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )),
                  ),
                ),
                _buildImageList(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: ListTile(
                        title: Text(
                          'Post Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.35,
                          ),
                        ),
                        subtitle: Text(
                          '(Description) Premium quality photoshoot for functional appearance & daily use',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
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
                const SizedBox(height: 10),
                Obx(
                  () => CLoginButton(
                    isLoading: postController.loading.value,
                    title: 'Save',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (imageList.isEmpty) {
                          Utils.showErrorMessage('Please upload image');
                          return;
                        }
                        if (websiteC.text.isNotEmpty) {
                          bool isValid = Utils.isValidUrl(websiteC.text);
                          if (!isValid) {
                            if (kDebugMode) {
                              print('invalid url');
                            }
                            Utils.showErrorMessage(
                                'Please add valid website link');
                            return;
                          }
                          if (kDebugMode) {
                            print('valid url');
                          }
                        }
                        postController.addPost(
                            companyId: companyController.selectedCompanyId.value
                                .toString(),
                            postName: postNameC.text,
                            buttonId: dropControllerBottom.selectData.value.id
                                .toString(),
                            imagePath: imageList,
                            postDescription: postDesC.text,
                            website: websiteC.text);
                      }
                    },
                    buttonColor: AdtipColors.black,
                    textColor: AdtipColors.white,
                    showImage: false,
                  ),
                ),
                CLoginButton(
                  title: 'No Thanks',
                  onTap: () {
                    dashboardController.changeWidget(value: 2);
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
    );
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

  // Future<void> pickImage() async {
  //   final picker = ImagePicker();
  //
  //   try {
  //     final pickedFile = await picker.pickMedia();
  //
  //     if (pickedFile != null) {
  //       bool isImage = pickedFile.path
  //           .toLowerCase()
  //           .contains(RegExp(r'\.(jpeg|jpg|gif|png)'));
  //       bool isVideo = pickedFile.path
  //           .toLowerCase()
  //           .contains(RegExp(r'\.(mp4|mov|avi|mkv)'));
  //       showLoaderDialog(context, Colors.blue);
  //       if (isImage) {
  //         String imageUrl = await Utils.uploadImageToAwsAmplify(
  //             path: pickedFile.path, folderName: 'CompanyPostsImages');
  //         setState(() {
  //           imageList.add(imageUrl);
  //         });
  //       } else if (isVideo) {
  //         print('picked is video');
  //         String videoUrl = await Utils.uploadVideoToAwsAmplify(
  //             path: pickedFile.path, folderName: 'CompanyPostsVideos');
  //         setState(() {
  //           imageList.add(videoUrl);
  //         });
  //       }
  //
  //       // await uploadImagesAWS(pickedFile);
  //
  //       Navigator.of(context).pop();
  //     } else {
  //       print('No image selected.');
  //     }
  //   } catch (e) {
  //     print('Error picking image: $e');
  //   }
  // }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Add Post',
        style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AdtipColors.black),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: CIconImage(
            image: AdtipAssets.SUPPORT_AGENT_ICON,
          ),
        )
      ],
    );
  }

  void _removeImage(int index) {
    setState(() {
      imageList.removeAt(index);
    });
  }

  Widget _buildImageList() {
    return Container(
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
}
