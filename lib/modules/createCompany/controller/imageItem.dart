import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';

class ImageItem extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool? showDummyImage;
  final bool? showCircleAvatar;
  final String? dummyImagePath;
  final bool? removeHTTP;

  const ImageItem({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.showDummyImage,
    this.showCircleAvatar = true,
    this.dummyImagePath,
    this.removeHTTP,
  });

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  late Future<http.Response> _imageResponse;

  @override
  void initState() {
    super.initState();
    _imageResponse = http.get(
      Uri.parse(
          widget.removeHTTP == true ? widget.url : 'http://${widget.url}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization":
            "Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}"
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: _imageResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data!.bodyBytes,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
            );
          }
        }
        if (widget.showDummyImage == true) {
          if (widget.showCircleAvatar == true) {
            return CircleAvatar(
              radius: 50,
              backgroundImage:
                  const AssetImage('assets/images/dummy-profile.png'),
            );
          } else {
            return Image.asset(
              "assets/extra/Rectangle1.png",
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
