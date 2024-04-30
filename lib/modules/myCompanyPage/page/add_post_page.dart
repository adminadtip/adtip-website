import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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
import '../controller/post_controller.dart';
import '../widgets/c_text_form_filed_underline.dart';
import 'widget/button/drop.dart';
import 'widget/button/drop_controller.dart';

class AddPostPage extends StatefulWidget {
  final String companyId;
  const AddPostPage({super.key, required this.companyId});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  List imageList = [];
  TextEditingController displayC = TextEditingController();
  TextEditingController postNameC = TextEditingController();
  TextEditingController postDesC = TextEditingController();
  TextEditingController websiteC = TextEditingController();

  DropControllerBottons dropControllerBottom = Get.put(DropControllerBottons());
  final PostController postController = Get.put(PostController());
  @override
  void initState() {
    super.initState();
    dropControllerBottom.getButtonList();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdtipColors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                Text('Target button to displays',
                    style: TextStyle(fontSize: 14)),
                Obx(
                  () => TextFormField(
                    controller: displayC
                      ..text = dropControllerBottom.selectData.value.name ?? "",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DropDownBottons(),
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
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )),
                  ),
                ),
                _buildImageList(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
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
                        child: Text(
                          'Upload Images',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Obx(
                  () => CLoginButton(
                    isLoading: postController.loading.value,
                    title: 'Save',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        postController.addPost(
                            companyId: widget.companyId,
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
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickMedia();

      if (pickedFile != null) {
        bool isImage = pickedFile.path
            .toLowerCase()
            .contains(RegExp(r'\.(jpeg|jpg|gif|png)'));
        bool isVideo = pickedFile.path
            .toLowerCase()
            .contains(RegExp(r'\.(mp4|mov|avi|mkv)'));
        showLoaderDialog(context, Colors.blue);
        if (isImage) {
          String imageUrl = await Utils.uploadImageToAwsAmplify(
              path: pickedFile.path, folderName: 'CompanyPostsImages');
          setState(() {
            imageList.add(imageUrl);
          });
        } else if (isVideo) {
          print('picked is video');
          String videoUrl = await Utils.uploadVideoToAwsAmplify(
              path: pickedFile.path, folderName: 'CompanyPostsVideos');
          setState(() {
            imageList.add(videoUrl);
          });
        }

        // await uploadImagesAWS(pickedFile);

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

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
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: const CIconImage(
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
                          child: CircleAvatar(
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
