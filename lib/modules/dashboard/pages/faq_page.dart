import 'package:flutter/material.dart';

import '../../authentication/pages/landing_page.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'How can We help you',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FAQWidget(
                    title: 'What is AdTip?',
                    subtitle:
                        'AdTip is created to establish a commercial advertising space by setting up an innovative platform that allows the viewer to earn cash through in-app advertisements. Users can earn while watching ads, making the experience not only engaging but also rewarding.',
                  ),
                  FAQWidget(
                      title: 'How does AdTip work?',
                      subtitle:
                          "Each rupee spent by advertisers for their ad will be directly credited to viewer's wallet for viewing the ad.  It's a win-win situation for both the parties.  Viewer's can withdraw the money at any time."),
                  FAQWidget(
                      title:
                          'Is there a limit to how many ads I can watch daily?',
                      subtitle: 'No'),
                  FAQWidget(
                      title: 'What type of ads will I see on AdTip?',
                      subtitle:
                          'Adtip features a variety of ads from different industries, including retail, technology, entertainment, and more.'),
                  FAQWidget(
                      title: 'Is AdTip free to use?',
                      subtitle:
                          'Yes, signing up and using Adtip to view ads and earn money is completely free for customers.'),
                  FAQWidget(
                      title: 'How can I sign up as an advertiser on Adtip?',
                      subtitle:
                          'Advertisers can sign up by visiting the Adtip website and creating an advertiser account. From there, you can create and manage your ad campaigns.'),
                  FAQWidget(
                      title: 'What are the benefits of advertising with Adtip?',
                      subtitle:
                          'Advertising with Adtip not only reaches a targeted audience but also engages viewers more effectively by directly crediting money to their wallet, leading to higher ad retention and engagement rates.'),
                  FAQWidget(
                      title: 'Is my personal information safe with Adtip?',
                      subtitle:
                          'Yes, Adtip prioritizes the privacy and security of your personal information. We use advanced encryption and security protocols to protect your data. Please review our privacy policy for more details.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
