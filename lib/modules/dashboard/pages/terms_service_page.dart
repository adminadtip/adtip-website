import 'package:flutter/material.dart';

class TermsOfServiceText extends StatelessWidget {
  const TermsOfServiceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String termsOfService = '''
Terms of Service for AdTip

Welcome to AdTip! These Terms of Service ("Terms") govern your use of the AdTip mobile application ("App") and any related services provided by AdTip ("we," "us," or "our"). By accessing or using the App, you agree to these Terms. If you do not agree with these Terms, please do not use the App.

1. Account Registration

1.1. To use the App, you must create an account. You agree to provide accurate, current, and complete information during the registration process.

1.2. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.

1.3. You agree not to share your account credentials with others. If you believe your account has been compromised, please contact us immediately.

2. Content Usage

2.1. You may use the App to watch ads, upload videos, and participate in shopping activities as provided by AdTip.

2.2. You may not use the App for any illegal or unauthorized purpose, including but not limited to copyright infringement.

2.3. You agree not to engage in any activity that could harm or disrupt the App or its services.

3. Earnings and Payments

3.1. By watching ads and participating in shopping, you may earn money or discounts as provided by AdTip.

3.2. Payments and earnings are subject to specific terms outlined in the App and may be adjusted or canceled at AdTip's discretion.

3.3. Any disputes regarding earnings must be reported to AdTip within 30 days of the transaction.

4. User Conduct

4.1. You agree to use the App in compliance with all applicable laws and regulations.

4.2. You must not engage in any activities that disrupt the App, its services, or other users' experiences.

4.3. Harassment, abusive behavior, or any form of misconduct towards other users or AdTip staff is strictly prohibited.

5. Privacy and Data

5.1. Your use of the App is subject to our Privacy Policy, which governs how we collect, use, and disclose your personal information.

5.2. By using the App, you consent to the collection and use of your data as described in our Privacy Policy.

6. Termination

6.1. AdTip may, at its discretion, terminate or suspend your account if you violate these Terms or engage in any behavior that is harmful to the App, its users, or AdTip.

6.2. You may terminate your account at any time by contacting AdTip support.

6.3. Upon termination, your right to use the App will cease immediately.

7. Updates and Changes

7.1. AdTip may update these Terms or make changes to the App at any time. You will be notified of any significant changes.

7.2. Continued use of the App after changes have been made constitutes your acceptance of the new Terms.

8. Disclaimers and Limitation of Liability

8.1. The App is provided "as is," and AdTip makes no warranties regarding its reliability, accuracy, or availability.

8.2. In no event will AdTip be liable for any damages or losses resulting from the use of the App.

8.3. AdTip does not guarantee that the App will be available at all times or that it will be free from errors or interruptions.

9. Governing Law and Jurisdiction

9.1. These Terms are governed by the laws of [Your Jurisdiction], and any disputes will be subject to the exclusive jurisdiction of the courts in [Your Jurisdiction].

9.2. Any claims or disputes arising from these Terms must be resolved in the courts located in [Your Jurisdiction].

10. Refund Policy

10.1. We don't provide refund policy.

11. GST Name
Adtip (OPC) Pvt. Ltd.

By using the AdTip App, you agree to these Terms and acknowledge that you have read and understood them. If you have any questions about these Terms, please contact us at [Your Contact Information].
    ''';

    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            termsOfService,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
