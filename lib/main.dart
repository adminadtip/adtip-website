import 'dart:async';
import 'dart:html';
import 'package:adtip_web_3/modules/authentication/pages/landing_page.dart';
import 'package:adtip_web_3/modules/dashboard/pages/dashboard_page.dart';
import 'package:adtip_web_3/routes/app_pages.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'amplifyconfiguration.dart';
import 'helpers/local_database/local_prefs.dart';
import 'helpers/local_database/sharedpref_key.dart';

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([auth, storage]);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

void main() async {
  await _configureAmplify();
  setPathUrlStrategy();
  await LocalPrefs().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  void initState() {
    // TODO: implement initState
    boardingShow();
    super.initState();
  }

  void openAppUrl() {
    // Attempt to open the custom URL scheme
    window.location.assign('myapp://');
  }

  void redirectToPlayStore() {
    // Replace <your_app_package_name> with your app's package name in the Play Store
    const playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app';
    window.location.assign(playStoreUrl);
  }

  void redirectToDifferentPage() {
    // Redirect to a different page
    window.location.assign('https://adtip.in');
  }

  void boardingShow() async {
    final uri = Uri.parse(window.location.href);
    final pathSegments = uri.pathSegments;
    print('path segment ${pathSegments.first}');
    if (pathSegments.isNotEmpty && pathSegments.first == 'mob') {
      Future.delayed(const Duration(seconds: 1), redirectToPlayStore);
    } else {
      // Redirect to a different page if the path is not /mob/
      // redirectToDifferentPage();
      token = LocalPrefs().getStringPref(
        key: SharedPreferenceKey.UserLoggedIn,
      );
    }

    print('token $token');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Adtip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: DashboardPage(),
      home: token == null ? const LandingPage() : const DashboardPage(),
      // getPages: AppPages.routes,
    );
  }
}
