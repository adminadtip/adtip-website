import 'dart:async';
import 'dart:html';
import 'package:adtip_web_3/modules/authentication/pages/landing_page.dart';
import 'package:adtip_web_3/modules/dashboard/pages/dashboard_page.dart';
import 'package:adtip_web_3/modules/dashboard/pages/privacy_page.dart';
import 'package:adtip_web_3/modules/dashboard/pages/terms_service_page.dart';
import 'package:adtip_web_3/modules/qr_ad_display/controller/qr_ad_controller.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  final qrCodeController = Get.put(QrCodeAdDisplayController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    boardingShow();
  }

  void boardingShow() async {
    final uri = Uri.parse(window.location.href);
    final pathSegments = uri.pathSegments;

    token = LocalPrefs().getStringPref(
      key: SharedPreferenceKey.UserLoggedIn,
    );
    if (pathSegments.isNotEmpty && pathSegments.first == 'mob') {
      // Future.delayed(const Duration(seconds: 1), redirectToPlayStore);
      qrCodeController.getQRCodeDetails(
          str: window.location.href, context: context);
    } else {}

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
      //getPages: AppPages.routes,
      routes: {
        '/privacy': (context) => const PrivacyPolicyText(),
        '/terms': (context) => const TermsOfServiceText(),
      },
    );
  }
}
