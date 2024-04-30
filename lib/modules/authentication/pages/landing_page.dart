import 'package:adtip_web_3/modules/authentication/controllers/landing_controller.dart';
import 'package:adtip_web_3/modules/authentication/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LandingController landingController = Get.put(LandingController());
  List<String> categories = [
    'Ad Posting',
    'Sales',
    'Business',
    'Enquiry',
    'Other'
  ];
  int _selectedIndex = 0;
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final message = TextEditingController();
  final featureKey = GlobalKey();
  final adModelKey = GlobalKey();
  final servicesKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// menus //home
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FA),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Adtip',
                              style: GoogleFonts.roboto(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFE0201)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset('images/adtip_icon.png'),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Home',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Scrollable.ensureVisible(
                                    servicesKey.currentContext!,
                                    duration:
                                        const Duration(milliseconds: 300));
                              },
                              child: Text(
                                'Services',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Scrollable.ensureVisible(
                                    featureKey.currentContext!,
                                    duration:
                                        const Duration(milliseconds: 300));
                              },
                              child: Text(
                                'Features',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Scrollable.ensureVisible(
                                    adModelKey.currentContext!,
                                    duration:
                                        const Duration(milliseconds: 300));
                              },
                              child: Text(
                                'Ad Models',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'FAQ',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Scrollable.ensureVisible(
                                    contactKey.currentContext!,
                                    duration:
                                        const Duration(milliseconds: 300));
                              },
                              child: Text(
                                'Get Demo',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF01C8CF)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(LoginScreen());
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF01C8CF)),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(const LoginScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF01C8CF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'World’s Best\nAdvertisement Platform',
                              style: GoogleFonts.inter(
                                fontSize: 64,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "your advertisement's\nmoney delivered to\nviewer wallet",
                              style: GoogleFonts.inter(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF01CFD5)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Your ads viewer to get money to watch your ads.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF717171),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(const LoginScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF01C8CF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                await landingController.launchURL();
                              },
                              child: Image.asset(
                                'assets/images/googleplay.png',
                                width: 162,
                                height: 47,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        Image.asset('assets/images/adtip_landing.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              ///features
              Column(
                key: featureKey,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 165,
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF373257)),
                    child: Center(
                      child: Text(
                        'Features',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1AD4D9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Innovative features to boost\nyour marketing',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 453,
                        height: 658,
                        child: Column(
                          children: [
                            Image.asset('assets/images/feature1.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Consumers earn money!',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Contrary to popular belief, Lore Ipsum is not simply random text. It has roots in a piece.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Learn More',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFF9F9F9)),
                        width: 453,
                        height: 658,
                        child: Column(
                          children: [
                            Image.asset('assets/images/feature2.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Interact with you customers!',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Contrary to popular belief, Lore Ipsum is not simply random text. It has roots in a piece.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Learn More',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 453,
                        height: 658,
                        child: Column(
                          children: [
                            Image.asset('assets/images/feature3.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Scan QR code to discover ads!',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Contrary to popular belief, Lore Ipsum is not simply random text. It has roots in a piece.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Learn More',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ///services
              Column(
                key: servicesKey,
                children: [
                  Column(
                    children: [
                      Text(
                        'Give the most value out of your ads!',
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Who is Nextcent suitable for?',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF717171)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset('assets/icons/adtip_advertiser.png'),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'AdTip ',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Advertiser\n',
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        color: const Color(0xFFE64646),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Panel',
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        color: const Color(0xFFE64646),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Our membership provides you with all\n the tools you required to get ahead in\n the advertisement.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset('assets/icons/adtip_consumer.png'),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'AdTip ',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Consumer\n',
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        color: const Color(0xFF11AD34),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Panel',
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        color: const Color(0xFF11AD34),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Our membership includes consumer\n app which is free of cost to use in\n Play Store.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset('assets/icons/adtip_analytics.png'),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'Advance\n',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Analytics',
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        color: const Color(0xFF11AD34),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'You will get advanced analytics page\n to analyse posted ads and big room\n for growth.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/wallet_illustrator.png'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Advertiser's money deliver to\ncustomer wallet",
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n'
                            'Sed sit amet justo ipsum. Sed accumsan quam vitae est\n'
                            'varius fringilla. Pellentesque placerat vestibulum lorem\n'
                            'sed porta. Nullam mattis tristique iaculis. Nullam pulvinar\n'
                            'sit amet risus pretium auctor. Etiam quis massa pulvinar,\n'
                            'aliquam quam vitae, tempus sem. Donec elementum pulvinar odio.',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF717171)),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/pana.png'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "How to post ads and connect with\n your audience?",
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n'
                            'Sed sit amet justo ipsum. Sed accumsan quam vitae est\n'
                            'varius fringilla. Pellentesque placerat vestibulum lorem\n'
                            'sed porta. Nullam mattis tristique iaculis. Nullam pulvinar\n'
                            'sit amet risus pretium auctor. Etiam quis massa pulvinar,\n'
                            'aliquam quam vitae, tempus sem. Donec elementum pulvinar odio.',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF717171)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 166,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFEFECFF)),
                        child: Center(
                          child: Text(
                            'How It Work',
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2CA2A6)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Promote smarter\nwith easy earning for user..',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 112,
                            width: 330,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2CA2A6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '01. Create Account',
                                style: GoogleFonts.nunito(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 112,
                            width: 330,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '02. Add Products',
                                style: GoogleFonts.nunito(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 112,
                            width: 330,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '03. Increase Sales',
                                style: GoogleFonts.nunito(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 582,
                            height: 374,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        'assets/images/user_promote.png'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Create AdTip account\n& start your Ad\nCampaign',
                                      style: GoogleFonts.nunito(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'It is a long established fact that a reader will be distracted by the readable content of a page from when looking at it layout. The point of using Lorem Ipsum',
                                  style: GoogleFonts.nunito(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const RoundedButton(
                                    text: 'Get Started', color: 0xFF242331),
                              ],
                            ),
                          ),
                          Image.asset('assets/images/promote_img.png'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),

              /// ad models
              Row(
                key: adModelKey,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 443,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const RoundedButton(text: 'Pricing', color: 0xFFEFECFF),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Simple and\nflexible pricing\nmodels',
                          style: GoogleFonts.nunito(
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'It is a long established fact that a reader the will be distracted by the readable content of a page from when looking at it layout. ',
                          style: GoogleFonts.nunito(
                            fontSize: 22,
                            color: const Color(0xFF797979),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Master Ads',
                          style: GoogleFonts.nunito(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 360,
                          height: 1,
                          color: const Color(0xFFD3D3D3),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '₹2',
                              style: GoogleFonts.nunito(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              ' / lead',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCFFEECC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Billed as prepaid charge',
                            style: GoogleFonts.nunito(
                                fontSize: 20, color: const Color(0xFFC68A15)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 360,
                          height: 1,
                          color: const Color(0xFFD3D3D3),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Longer duration to convey detailed\nmessages effectively.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Exclusivity, offering prime ad space for\nselect advertisers.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Multi-format support for versatility in ad\ncreation.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Ideal for brand awareness campaigns and\nproduct launches.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const RoundedButton(
                            text: 'Get Started', color: 0xFF242331),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Non-Skip Ads',
                          style: GoogleFonts.nunito(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 360,
                          height: 1,
                          color: const Color(0xFFD3D3D3),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '₹3',
                              style: GoogleFonts.nunito(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              ' / lead',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCFFEECC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Billed as prepaid charge',
                            style: GoogleFonts.nunito(
                                fontSize: 20, color: const Color(0xFFC68A15)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 360,
                          height: 1,
                          color: const Color(0xFFD3D3D3),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Guaranteed viewability for advertisers.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Higher completion rates compared to\ntraditional ads.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Uninterrupted viewing experience for\nusers.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Incentivized rewards for watching  full ad.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Reduced ad fatigue and frustration among\nusers.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: const Color(0xFF797979)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const RoundedButton(
                            text: 'Get Started', color: 0xFF242331),
                      ],
                    ),
                  ),
                ],
              ),

              /// contact
              Column(
                key: contactKey,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Get connected with us & grab this\nopportunity!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Out team member will contact you after filling this form.',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(40),
                    height: 1024,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFF01CFD5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Let’s discuss\non something cool\ntogether',
                              style: GoogleFonts.poppins(
                                  fontSize: 44, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 282,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/email.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'hello@adtip.in',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF570A57),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color(0xFFFD2120))),
                                    child: Row(
                                      children: [
                                        Image.asset('assets/icons/phone.png'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '+91 8148147171',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/location.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Andhra Pradesh, India',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 228,
                              height: 64,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('assets/icons/facebook.png'),
                                  CircleAvatar(
                                    backgroundColor: const Color(0xffFD2120),
                                    child:
                                        Image.asset('assets/icons/insta.png'),
                                  ),
                                  Image.asset('assets/icons/twit.png'),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 700,
                          height: 896,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'I’m interested in...',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF01CFD5)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                spacing: 8.0, // spacing between items
                                runSpacing: 8.0, // spacing between lines
                                children:
                                    List.generate(categories.length, (index) {
                                  return ChoiceChip(
                                    showCheckmark: false,
                                    label: Text(
                                      categories[index],
                                      style: TextStyle(
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    // Set the color of the selected category to red
                                    selectedColor: _selectedIndex == index
                                        ? Colors.red
                                        : Colors.white,
                                    selected: _selectedIndex == index,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedIndex = selected ? index : -1;
                                      });
                                    },
                                  );
                                }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter name';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Your Name'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: phoneNumber,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter phone number';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Phone Number'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: message,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter message';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Your Message'),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      width: 375,
                                      height: 78,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/icons/send.png'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Send Message',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// footer
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Color(0xFFF5F7FA)),
                    child: Text(
                      'Join the new road of\nmarketing with us.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 64, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Color(0xFF263238)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/adtip_icon.png',
                                  height: 49,
                                  width: 49,
                                ),
                                Text(
                                  'Adtip',
                                  style: GoogleFonts.roboto(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFFE0201)),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Copyright © 2024 AdTip pvt ltd.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'All rights reserved',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '8148147171',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'hello@adtip.in',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.asset('assets/icons/insta.png'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset('assets/icons/fb.png'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset('assets/icons/twitter.png'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset('assets/icons/youtube.png'),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'About Adtip',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Blog',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Contact Us',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Ad Model Pricing',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Clients',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Support',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Help Center',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Terms of Service',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Legal',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Privacy Policy',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Status',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stay up to date',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 300,
                              height: 100,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Your email address',
                                  hintStyle: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  suffixIcon:
                                      Image.asset('assets/icons/send.png'),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final int color;
  const RoundedButton({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Color(color)),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1AD4D9),
          ),
        ),
      ),
    );
  }
}
