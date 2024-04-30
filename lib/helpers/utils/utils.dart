import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static void showSuccessMessage(String message) {
    Get.snackbar(message, '',
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  static void showErrorMessage(String message) {
    Get.snackbar(message, '',
        backgroundColor: Colors.red, colorText: Colors.white);
  }

// get formated date to send in api.
  static String getDateYYYYMMDD() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    printLog(formattedDate); // 2016-01-25

    return formattedDate;
  }

// print only in debug mode
  static void printLog(String msg) {
    if (kDebugMode) {
      print(msg);
    }
  }

  static String timeAgo(DateTime date, {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String numberGen(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(0)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(0)} B";
    } else {
      return num.toString();
    }
  }

  static void showAlertDialog(
      {required BuildContext context,
      required String title,
      required String subtitle}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  static void showAlertDialogYesNo(
      {required BuildContext context,
      required String title,
      required VoidCallback function,
      required String subtitle}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    function();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  static Future<String> uploadImageToAwsAmplify(
      {required String path, required String folderName}) async {
    try {
      var uuid = Uuid();
      String newName = uuid.v4();
      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(path),
        key: '$folderName/$newName.jpg',
        // onProgress: (progress) {
        //   safePrint('Fraction completed: ${progress.fractionCompleted}');
        //   setState(() {
        //     value = progress.fractionCompleted;
        //   });
        // },
      ).result;
      //return 'https://adtip135224-dev.s3.amazonaws.com/public/videos/$newName.mp4';
      return 'https://d24boe3940mg96.cloudfront.net/public/$folderName/$newName.jpg';
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      Utils.showErrorMessage('Error uploading file.');
      rethrow;
    }
  }

  static Future<String> uploadVideoToAwsAmplify(
      {required String path, required String folderName}) async {
    try {
      var uuid = const Uuid();
      String newName = uuid.v4();
      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(path),
        key: '$folderName/$newName.mp4',
        // onProgress: (progress) {
        //   safePrint('Fraction completed: ${progress.fractionCompleted}');
        //   setState(() {
        //     value = progress.fractionCompleted;
        //   });
        // },
      ).result;
      //return 'https://adtip135224-dev.s3.amazonaws.com/public/videos/$newName.mp4';
      return 'https://d24boe3940mg96.cloudfront.net/public/$folderName/$newName.mp4';
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      Utils.showErrorMessage('Error uploading file.');
      rethrow;
    }
  }
}
