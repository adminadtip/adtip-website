import 'package:flutter/material.dart';

class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String privacyPolicy = '''
Privacy Policy for AdTip

This Privacy Policy describes how AdTip ("we," "us," or "our") collects, uses, and discloses information collected from users ("you" or "your") of the AdTip mobile application.

Information Collection and Use

We may collect personal information such as:

a.Name
b.Email address
c.Location data
d.Device information
e.Usage data
f.We collect this information to:

Provide and improve our services
Personalize user experience
Communicate with users
Analyze usage trends
Data Security

We take reasonable measures to protect your information from unauthorized access or disclosure. However, no method of transmission over the internet or electronic storage is 100% secure.

Third-Party Services

AdTip may contain links to third-party sites or services that...

1. Account Registration

1.1. To use the App, you must create an account. You agree to provide accurate, current, and complete information during the registration process.

1.2. You are responsible for maintaining the confidentiality of your account credentials. You are also responsible for all activities that occur under your account.

1.3. You agree not to share your account credentials with others.

2. Content Usage

2.1. You may use the App to watch ads, upload videos, and participate in shopping activities as provided by the Company.

2.2. You may not use the App for any illegal or unauthorized purpose, including but not limited to copyright infringement.

3. Earnings and Payments

3.1. By watching ads and participating in shopping, you may earn money or discounts as provided by the Company.

3.2. Payments and earnings will be subject to specific terms outlined in the App and may be adjusted or canceled at the Company's discretion.

4. User Conduct

4.1. You agree to use the App in compliance with all applicable laws and regulations.

4.2. You must not engage in any activities that disrupt the App, its services, or other users' experiences.

5. Privacy and Data

5.1. Your use of the App is subject to our Privacy Policy, which governs how we collect, use, and disclose your personal information.

6. Termination

6.1. The Company may, at its discretion, terminate or suspend your account if you violate these Terms or engage in any behavior that is harmful to the App, its users, or the Company.

7. Updates and Changes

7.1. The Company may update these Terms or make changes to the App at any time. You will be notified of any significant changes.

8. Disclaimers and Limitation of Liability

8.1. The App is provided "as is," and the Company makes no warranties regarding its reliability, accuracy, or availability.

8.2. In no event will the Company be liable for any damages or losses resulting from the use of the App.

9. Governing Law and Jurisdiction

9.1. These Terms are governed by the laws of [Your Jurisdiction], and any disputes will be subject to the exclusive jurisdiction of the courts in [Your Jurisdiction].

10. Refund Policy

10.1. We don't provide refund policy.

11. GST Name
Adtip (OPC) Pvt. Ltd.

By using the AdTip App, you agree to these Terms and acknowledge that you have read and understood them.
    ''';

    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            privacyPolicy,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
