import 'package:adtip_web_3/modules/authentication/controllers/landing_controller.dart';
import 'package:adtip_web_3/modules/authentication/pages/login_screen.dart';
import 'package:adtip_web_3/modules/calling/pages/callPage.dart';
import 'package:adtip_web_3/modules/dashboard/pages/terms_service_page.dart';
import 'package:adtip_web_3/modules/qr_ad_display/controller/qr_ad_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../helpers/constants/string_constants.dart';
import '../../../helpers/utils/utils.dart';
import '../../dashboard/pages/privacy_page.dart';
import '../widgets/drawer_item.dart';
import '../widgets/top_menu.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LandingController landingController = Get.put(LandingController());
  final qrController = Get.put(QrCodeAdDisplayController());
  List<String> categories = [
    'Ad Posting',
    'Sales',
    'Business',
    'Enquiry',
    'Other'
  ];
  int selectedIndex = 0;
  List<Map<String, dynamic>> data = [
    {
      'title': 'Create AdTip account & start your Ad Campaign',
      'subtitle':
          'Click on the get started button below. You will be prompted to verify your phone number through OTP. Once signed in, navigate to the "Create Company Page" section and fill in the required details. Congrats, Your company page is now available for posting ads.'
    },
    {
      'title': 'Add your company’s products on your Advertiser Page',
      'subtitle':
          'Once your account is set up, add your products or services to Adtip. Our platform supports a variety of ad models, allowing you to promote your offerings effectively and reach a targeted audience.'
    },
    {
      'title': 'Increase sales and improve your business in AdTip',
      'subtitle':
          'Watch your sales soar as you connect directly with viewers who engage with and like your ads. With Adtip, you can contact interested customers directly through the platform and sell anything with ease.'
    },
  ];
  int _selectedIndex = 0;
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final message = TextEditingController();
  final homeKey = GlobalKey();
  final featureKey = GlobalKey();
  final adModelKey = GlobalKey();
  final servicesKey = GlobalKey();
  final contactKey = GlobalKey();
  final faqKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Adtip'),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
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
                        Image.asset('assets/images/adtip_icon.png'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DrawerItem(
                          name: 'Home',
                          globalKey: homeKey,
                        ),
                        DrawerItem(
                          name: 'Services',
                          globalKey: servicesKey,
                        ),
                        DrawerItem(
                          name: 'Features',
                          globalKey: featureKey,
                        ),
                        DrawerItem(
                          name: 'Contact',
                          globalKey: contactKey,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Utils.showDialogDemoVideo(
                                context: context,
                                videoLink: StringConstants.bookAdDemo);
                          },
                          title: Text(
                            'How to Book Ad',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DrawerItem(
                          name: 'Ad Models',
                          globalKey: adModelKey,
                        ),
                        DrawerItem(
                          name: 'Get Demo',
                          globalKey: contactKey,
                        ),
                        DrawerItem(
                          name: 'FAQ',
                          globalKey: faqKey,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Utils.launchWeb(
                                uri: Uri.parse(StringConstants.whatsapp));
                          },
                          title: Text(
                            'WhatsApp',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///home
                  Container(
                    width: Get.width,
                    key: homeKey,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F7FA),
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'World’s Best\nAdvertisement Platform',
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Reaching right people\nevery time",
                              style: GoogleFonts.inter(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF01CFD5)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Get your viewers to earn money by watching your ads',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF717171),
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
                      Text(
                        'Innovative features to boost\nyour marketing',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/feature1.png',
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Viewers earn money',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'viewers on the Adtip app earn money by watching and sharing ads.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFF9F9F9)),
                            child: Column(
                              children: [
                                Image.asset('assets/images/feature2.png'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Interact with you customers!',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Direct interaction with viewers via the Invoice app call feature fosters real-time engagement.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset('assets/images/feature3.png',
                                  height: 300, fit: BoxFit.cover),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Offline to Online ads',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Any offline marketing medium can be converted into online ads',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///services
                  Column(
                    key: servicesKey,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/wallet_illustrator.png'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Your Advertiser's money deliver to\nviewer's wallet",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                softWrap: true,
                                "Experience the future of advertising where every rupee spent reaches its true destination. Your advertising budget isn't just spent; it's invested directly into the wallets of your viewers. This ensures genuine engagement and appreciation from your audience.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF717171)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Scrollable.ensureVisible(
                                        contactKey.currentContext!,
                                        duration:
                                            const Duration(milliseconds: 300));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF01C8CF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  child: const Text(
                                    'Book Ad Demo',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/pana.png'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "How to post ads and connect with\n your audience?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                softWrap: true,
                                textAlign: TextAlign.center,
                                'To effectively connect with your audience through ads, begin with a simple sign-up process. Provide company information to establish credibility and transparency. Next, carefully select your target audience based on demographics, interests, and location to ensure your ads reach the right people. Make budget decisions aligned with your advertising goals and resources. Get, Set, launch your advertising campaign.',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF717171)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Scrollable.ensureVisible(
                                        contactKey.currentContext!,
                                        duration:
                                            const Duration(milliseconds: 300));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF01C8CF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  child: const Text(
                                    'Book Ad Demo',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Promote smarter\nwith easy earning for user..',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 0
                                        ? const Color(0xFF2CA2A6)
                                        : const Color(0xFFF9F9F9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '01. Create Account',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex == 0
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 1
                                        ? const Color(0xFF2CA2A6)
                                        : const Color(0xFFF9F9F9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '02. Add Products',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex == 1
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 2
                                        ? const Color(0xFF2CA2A6)
                                        : const Color(0xFFF9F9F9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '03. Increase Sales',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex == 2
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (selectedIndex == 0)
                                    Text(
                                      data[0]['title'],
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (selectedIndex == 1)
                                    Text(
                                      data[1]['title'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (selectedIndex == 2)
                                    Text(
                                      data[2]['title'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (selectedIndex == 0)
                                    Text(
                                      data[0]['subtitle'],
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                      ),
                                    ),
                                  if (selectedIndex == 1)
                                    Text(
                                      data[1]['subtitle'],
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                      ),
                                    ),
                                  if (selectedIndex == 2)
                                    Text(
                                      data[2]['subtitle'],
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SizedBox(
                      height: 600,
                      width: Get.width,
                      child: ListView(
                        key: adModelKey,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Master Ads',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '₹2',
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      ' / lead',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
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
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: const Color(0xFFC68A15)),
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
                                  'Longer duration to convey detailed\nmessages effectively.'
                                  '(24*7 ad on\ntop of the page which is displayed when\nthe user opens app)',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Offering prime ad space for select advertisers.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Multi-format support for versatility in ad creation.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Ideal for brand awareness campaigns and\nproduct launches.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Viewer is paid 30% to view and 70% if they\ninteract with the video.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Interact with customers on voice call.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
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
                                  'Non-Skip Ads',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '₹3',
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      ' / lead',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
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
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: const Color(0xFFC68A15)),
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
                                  'Advertisers benefit from guaranteed\nviewability and higher completion rates.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Users enjoy an incentivized rewards only for\nfull ad engagement. ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'If customer doesn’t see the ad, they don’t\nget money. There will be a pop up as shown.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Incentivized rewards for watching  full ad.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Viewer is paid 30% to view and 70% if\nthey like the video.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Interact with customers on voice app.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
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
                                  'QR Video Ads',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '₹3',
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      ' / lead',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
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
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: const Color(0xFFC68A15)),
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
                                  'Bridge between offline and online\nmarketing efforts.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Versatility in application, suitable for\nvarious industries.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Convenient access to additional content.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Incentivized rewards for watching  full ad.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Interactive storytelling for deeper\naudience engagement.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Get database of users who have interacted with your ad.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'If the customer doesn’t view the ad,\nyour money spent will be refunded.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'If the customer is not entering their phone number\n'
                                  'after scanning and is not a viewer,\nthe money will not be credited.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF797979)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Out team member will contact you after filling this form.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        height: 900,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xFF01CFD5),
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Let’s discuss on something cool together',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/icons/email.png'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SelectableText(
                                          'hello@adtip.in',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF570A57),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color(0xFFFD2120))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset('assets/icons/phone.png'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SelectableText(
                                            '+91 81481471712',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Utils.launchWeb(
                                        uri: Uri.parse(
                                            'https://www.google.com/maps/place/AdTip/@17.7231673,83.3250019,17z/data=!3m1!4b1!4m6!3m5!1s0x3a3943a988e2d721:0x2a61e920c4a01444!8m2!3d17.7231673!4d83.3250019!16s%2Fg%2F11vxttv598?entry=ttu'));
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/icons/location.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'AU South Campus, Andhra University,Andhra Pradesh,\nIndia,Pincode:53000',
                                        maxLines: 2,
                                        softWrap: true,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Utils.launchWeb(
                                                  uri: Uri.parse(
                                                      StringConstants.fbLink));
                                            },
                                            child: Image.asset(
                                                'assets/icons/facebook.png')),
                                        InkWell(
                                          onTap: () {
                                            Utils.launchWeb(
                                                uri: Uri.parse(
                                                    StringConstants.instLink));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                const Color(0xffFD2120),
                                            child: Image.asset(
                                                'assets/icons/insta.png'),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Utils.launchWeb(
                                                  uri: Uri.parse(StringConstants
                                                      .linkedinLink));
                                            },
                                            child: Image.asset(
                                                'assets/icons/linkedin.png')),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: 700,
                              height: 500,
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
                                    children: List.generate(categories.length,
                                        (index) {
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
                                            _selectedIndex =
                                                selected ? index : -1;
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
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                                          width: 200,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                              child: Obx(() => landingController
                                                      .isLoading.value
                                                  ? const CircularProgressIndicator()
                                                  : InkWell(
                                                      onTap: () async {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          formKey.currentState!
                                                              .save();
                                                          await landingController
                                                              .submitWebsiteMessage(
                                                                  name: name.text
                                                                      .trim(),
                                                                  message: message
                                                                      .text
                                                                      .trim(),
                                                                  mobile:
                                                                      phoneNumber
                                                                          .text
                                                                          .trim(),
                                                                  type: categories[
                                                                      _selectedIndex]);
                                                          name.text = '';
                                                          phoneNumber.text = '';
                                                          message.text = '';
                                                          Utils.showDialogDemoVideo(
                                                              context: context,
                                                              videoLink:
                                                                  StringConstants
                                                                      .bookAdDemo);
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                              'assets/icons/send.png'),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'Send Message',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ))),
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
                  const SizedBox(
                    height: 20,
                  ),

                  ///faq
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      key: faqKey,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        FAQWidgetMob(
                          title: 'What is AdTip?',
                          subtitle:
                              'AdTip is created to establish a commercial advertising space by setting up an innovative platform that allows the viewer to earn cash through in-app advertisements. Users can earn while watching ads, making the experience not only engaging but also rewarding.',
                        ),
                        FAQWidgetMob(
                            title: 'How does AdTip work?',
                            subtitle:
                                "Each rupee spent by advertisers for their ad will be directly credited to viewer's wallet for viewing the ad.  It's a win-win situation for both the parties.  Viewer's can withdraw the money at any time."),
                        FAQWidgetMob(
                            title:
                                'Is there a limit to how many ads I can watch daily?',
                            subtitle: 'No'),
                        FAQWidgetMob(
                            title: 'What type of ads will I see on AdTip?',
                            subtitle:
                                'Adtip features a variety of ads from different industries, including retail, technology, entertainment, and more.'),
                        FAQWidgetMob(
                            title: 'Is AdTip free to use?',
                            subtitle:
                                'Yes, signing up and using Adtip to view ads and earn money is completely free for customers.'),
                        FAQWidgetMob(
                            title:
                                'How can I sign up as an advertiser on Adtip?',
                            subtitle:
                                'Advertisers can sign up by visiting the Adtip website and creating an advertiser account. From there, you can create and manage your ad campaigns.'),
                        FAQWidgetMob(
                            title:
                                'What are the benefits of advertising with Adtip?',
                            subtitle:
                                'Advertising with Adtip not only reaches a targeted audience but also engages viewers more effectively by directly crediting money to their wallet, leading to higher ad retention and engagement rates.'),
                        FAQWidgetMob(
                            title:
                                'Is my personal information safe with Adtip?',
                            subtitle:
                                'Yes, Adtip prioritizes the privacy and security of your personal information. We use advanced encryption and security protocols to protect your data. Please review our privacy policy for more details.'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                        decoration:
                            const BoxDecoration(color: Color(0xFFF5F7FA)),
                        child: Text(
                          'Join the new road of\nmarketing with us.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        decoration:
                            const BoxDecoration(color: Color(0xFF263238)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFFFE0201)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Copyright © 2024 AdTip (OPC) pvt ltd.',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
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
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SelectableText(
                                  '+91 81481471712',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SelectableText(
                                  'hello@adtip.in',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Scrollable.ensureVisible(
                                        homeKey.currentContext!,
                                        duration:
                                            const Duration(milliseconds: 300));
                                  },
                                  child: Text(
                                    'About Adtip',
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Scrollable.ensureVisible(
                                        contactKey.currentContext!,
                                        duration:
                                            const Duration(milliseconds: 300));
                                  },
                                  child: Text(
                                    'Contact Us',
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Scrollable.ensureVisible(
                                        adModelKey.currentContext!,
                                        duration:
                                            const Duration(milliseconds: 300));
                                  },
                                  child: Text(
                                    'Ad Model Pricing',
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Support',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Help',
                                      style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SelectableText(
                                      '+91 81481471712',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(const TermsOfServiceText());
                                  },
                                  child: Text(
                                    'Terms of Service',
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // ),
                                InkWell(
                                  onTap: () {
                                    Get.to(const PrivacyPolicyText());
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Utils.launchWeb(
                                        uri: Uri.parse(
                                            StringConstants.whatsapp));
                                  },
                                  child: Text(
                                    "WhatsApp",
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
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
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// menus //home
                Container(
                  key: homeKey,
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
                              Image.asset('assets/images/adtip_icon.png'),
                            ],
                          ),
                          Row(
                            children: [
                              TopMenu(
                                name: 'Home',
                                globalKey: homeKey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TopMenu(
                                name: 'Services',
                                globalKey: servicesKey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TopMenu(
                                name: 'Features',
                                globalKey: featureKey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Utils.showDialogDemoVideo(
                                      context: context,
                                      videoLink: StringConstants.bookAdDemo);
                                },
                                child: Text(
                                  'How to Book Ad',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TopMenu(
                                name: 'Ad Models',
                                globalKey: adModelKey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TopMenu(
                                name: 'Get Demo',
                                globalKey: contactKey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TopMenu(
                                name: 'FAQ',
                                globalKey: faqKey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Utils.launchWeb(
                                      uri: Uri.parse(StringConstants.whatsapp));
                                },
                                child: Text(
                                  'WhatsApp',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(const LoginScreen())?.then((value) => {
                                        if (value != null)
                                          {
                                            Scrollable.ensureVisible(
                                                contactKey.currentContext!,
                                                duration: const Duration(
                                                    milliseconds: 300))
                                          }
                                      });
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
                                  Get.to(const LoginScreen())?.then((value) => {
                                        if (value != null)
                                          {
                                            Scrollable.ensureVisible(
                                                contactKey.currentContext!,
                                                duration: const Duration(
                                                    milliseconds: 300))
                                          }
                                      });
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
                                "Reaching right people\nevery time",
                                style: GoogleFonts.inter(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF01CFD5)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Get your viewers to earn money by watching your ads',
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
                                  Get.to(const LoginScreen())?.then((value) => {
                                        if (value != null)
                                          {
                                            Scrollable.ensureVisible(
                                                contactKey.currentContext!,
                                                duration: const Duration(
                                                    milliseconds: 300))
                                          }
                                      });
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
                    // Container(
                    //   width: 165,
                    //   height: 75,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(30),
                    //       color: const Color(0xFF373257)),
                    //   child: Center(
                    //     child: Text(
                    //       'Features',
                    //       style: GoogleFonts.inter(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w500,
                    //         color: const Color(0xFF1AD4D9),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      'Innovative features to boost\nyour marketing',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
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
                                'Viewers earn money',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'viewers on the Adtip app earn money by watching and sharing ads.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   'Learn More',
                              //   style: GoogleFonts.inter(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //     decoration: TextDecoration.underline,
                              //   ),
                              // ),
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
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Direct interaction with viewers via the Invoice app call feature fosters real-time engagement.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   'Learn More',
                              //   style: GoogleFonts.inter(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //     decoration: TextDecoration.underline,
                              //   ),
                              // ),
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
                                'Offline to Online ads',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Any offline marketing medium can be converted into online ads',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   'Learn More',
                              //   style: GoogleFonts.inter(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //     decoration: TextDecoration.underline,
                              //   ),
                              // ),
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
                    // Column(
                    //   children: [
                    //     Text(
                    //       'Give the most value out of your ads!',
                    //       style: GoogleFonts.inter(
                    //         fontSize: 36,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     Text(
                    //       'Who is Nextcent suitable for?',
                    //       style: GoogleFonts.inter(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w400,
                    //           color: const Color(0xFF717171)),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Card(
                    //       color: Colors.white,
                    //       child: Column(
                    //         children: [
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           Image.asset('assets/icons/adtip_advertiser.png'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           RichText(
                    //             textAlign: TextAlign.center,
                    //             text: TextSpan(
                    //                 text: 'AdTip ',
                    //                 style: GoogleFonts.inter(
                    //                   fontSize: 28,
                    //                   fontWeight: FontWeight.w700,
                    //                 ),
                    //                 children: [
                    //                   TextSpan(
                    //                     text: 'Advertiser\n',
                    //                     style: GoogleFonts.inter(
                    //                       fontSize: 28,
                    //                       color: const Color(0xFFE64646),
                    //                       fontWeight: FontWeight.w700,
                    //                     ),
                    //                   ),
                    //                   TextSpan(
                    //                     text: 'Panel',
                    //                     style: GoogleFonts.inter(
                    //                       fontSize: 28,
                    //                       color: const Color(0xFFE64646),
                    //                       fontWeight: FontWeight.w700,
                    //                     ),
                    //                   ),
                    //                 ]),
                    //           ),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Our membership provides you with all\n the tools you required to get ahead in\n the advertisement.',
                    //               textAlign: TextAlign.center,
                    //               style: GoogleFonts.inter(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Card(
                    //       color: Colors.white,
                    //       child: Column(
                    //         children: [
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           Image.asset('assets/icons/adtip_consumer.png'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           RichText(
                    //             textAlign: TextAlign.center,
                    //             text: TextSpan(
                    //                 text: 'AdTip ',
                    //                 style: GoogleFonts.inter(
                    //                   fontSize: 28,
                    //                   fontWeight: FontWeight.w700,
                    //                 ),
                    //                 children: [
                    //                   TextSpan(
                    //                     text: 'Consumer\n',
                    //                     style: GoogleFonts.inter(
                    //                       fontSize: 28,
                    //                       color: const Color(0xFF11AD34),
                    //                       fontWeight: FontWeight.w700,
                    //                     ),
                    //                   ),
                    //                   TextSpan(
                    //                     text: 'Panel',
                    //                     style: GoogleFonts.inter(
                    //                       fontSize: 28,
                    //                       color: const Color(0xFF11AD34),
                    //                       fontWeight: FontWeight.w700,
                    //                     ),
                    //                   ),
                    //                 ]),
                    //           ),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Our membership includes consumer\n app which is free of cost to use in\n Play Store.',
                    //               textAlign: TextAlign.center,
                    //               style: GoogleFonts.inter(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Card(
                    //       color: Colors.white,
                    //       child: Column(
                    //         children: [
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           Image.asset('assets/icons/adtip_analytics.png'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           RichText(
                    //             textAlign: TextAlign.center,
                    //             text: TextSpan(
                    //                 text: 'Advance\n',
                    //                 style: GoogleFonts.inter(
                    //                   fontSize: 28,
                    //                   fontWeight: FontWeight.w700,
                    //                 ),
                    //                 children: [
                    //                   TextSpan(
                    //                     text: 'Analytics',
                    //                     style: GoogleFonts.inter(
                    //                       fontSize: 28,
                    //                       color: const Color(0xFF11AD34),
                    //                       fontWeight: FontWeight.w700,
                    //                     ),
                    //                   ),
                    //                 ]),
                    //           ),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'You will get advanced analytics page\n to analyse posted ads and big room\n for growth.',
                    //               textAlign: TextAlign.center,
                    //               style: GoogleFonts.inter(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                              "Your Advertiser's money deliver to\nviewer's wallet",
                              style: GoogleFonts.inter(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: Get.width / 2 - 200,
                              child: Text(
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                "Experience the future of advertising where every rupee spent reaches its true destination. Your advertising budget isn't just spent; it's invested directly into the wallets of your viewers. This ensures genuine engagement and appreciation from your audience.",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF717171)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Scrollable.ensureVisible(
                                      contactKey.currentContext!,
                                      duration:
                                          const Duration(milliseconds: 300));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF01C8CF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                child: const Text(
                                  'Book Ad Demo',
                                  style: TextStyle(color: Colors.white),
                                ))
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
                            SizedBox(
                              width: Get.width / 2 - 200,
                              child: Text(
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                'To effectively connect with your audience through ads, begin with a simple sign-up process. Provide company information to establish credibility and transparency. Next, carefully select your target audience based on demographics, interests, and location to ensure your ads reach the right people. Make budget decisions aligned with your advertising goals and resources. Get, Set, launch your advertising campaign.',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF717171)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Scrollable.ensureVisible(
                                      contactKey.currentContext!,
                                      duration:
                                          const Duration(milliseconds: 300));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF01C8CF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                child: const Text(
                                  'Book Ad Demo',
                                  style: TextStyle(color: Colors.white),
                                ))
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
                              style: GoogleFonts.inter(
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
                          style: GoogleFonts.inter(
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
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              child: Container(
                                height: 112,
                                width: 330,
                                decoration: BoxDecoration(
                                  color: selectedIndex == 0
                                      ? const Color(0xFF2CA2A6)
                                      : const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '01. Create Account',
                                    style: GoogleFonts.inter(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              child: Container(
                                height: 112,
                                width: 330,
                                decoration: BoxDecoration(
                                  color: selectedIndex == 1
                                      ? const Color(0xFF2CA2A6)
                                      : const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '02. Add Products',
                                    style: GoogleFonts.inter(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 2;
                                });
                              },
                              child: Container(
                                height: 112,
                                width: 330,
                                decoration: BoxDecoration(
                                  color: selectedIndex == 2
                                      ? const Color(0xFF2CA2A6)
                                      : const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '03. Increase Sales',
                                    style: GoogleFonts.inter(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
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
                              height: 500,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                          'assets/images/user_promote.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      if (selectedIndex == 0)
                                        SizedBox(
                                          width: 500,
                                          child: Text(
                                            data[0]['title'],
                                            softWrap: true,
                                            style: GoogleFonts.inter(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      if (selectedIndex == 1)
                                        SizedBox(
                                          width: 500,
                                          child: Text(
                                            data[1]['title'],
                                            style: GoogleFonts.inter(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      if (selectedIndex == 2)
                                        SizedBox(
                                          width: 500,
                                          child: Text(
                                            data[2]['title'],
                                            style: GoogleFonts.inter(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (selectedIndex == 0)
                                    SizedBox(
                                      width: Get.width / 2 - 200,
                                      child: Text(
                                        data[0]['subtitle'],
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.inter(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  if (selectedIndex == 1)
                                    SizedBox(
                                      width: Get.width / 2 - 200,
                                      child: Text(
                                        data[1]['subtitle'],
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.inter(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  if (selectedIndex == 2)
                                    SizedBox(
                                      width: Get.width / 2 - 200,
                                      child: Text(
                                        data[2]['subtitle'],
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.inter(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(const LoginScreen())
                                          ?.then((value) => {
                                                if (value != null)
                                                  {
                                                    Scrollable.ensureVisible(
                                                        contactKey
                                                            .currentContext!,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300))
                                                  }
                                              });
                                    },
                                    child: const RoundedButton(
                                        text: 'Get Started', color: 0xFF242331),
                                  ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    height: 900,
                    width: Get.width,
                    child: ListView(
                      key: adModelKey,
                      scrollDirection: Axis.horizontal,
                      children: [
                        // SizedBox(
                        //   width: 443,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       const RoundedButton(
                        //           text: 'Pricing', color: 0xFFEFECFF),
                        //       const SizedBox(
                        //         height: 10,
                        //       ),
                        //       Text(
                        //         'Simple and\nflexible pricing\nmodels',
                        //         style: GoogleFonts.inter(
                        //           fontSize: 50,
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         height: 10,
                        //       ),
                        //       Text(
                        //         'It is a long established fact that a reader the will be distracted by the readable content of a page from when looking at it layout. ',
                        //         style: GoogleFonts.inter(
                        //           fontSize: 22,
                        //           color: const Color(0xFF797979),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Master Ads',
                                style: GoogleFonts.inter(
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
                                    style: GoogleFonts.inter(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    ' / lead',
                                    style: GoogleFonts.inter(
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
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      color: const Color(0xFFC68A15)),
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
                                'Longer duration to convey detailed\nmessages effectively.'
                                '(24*7 ad on\ntop of the page which is displayed when\nthe user opens app)',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Offering prime ad space for select advertisers.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Multi-format support for versatility in ad creation.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Ideal for brand awareness campaigns and\nproduct launches.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Viewer is paid 30% to view and 70% if they\ninteract with the video.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Interact with customers on voice call.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const LoginScreen())?.then((value) => {
                                        if (value != null)
                                          {
                                            Scrollable.ensureVisible(
                                                contactKey.currentContext!,
                                                duration: const Duration(
                                                    milliseconds: 300))
                                          }
                                      });
                                },
                                child: const RoundedButton(
                                    text: 'Get Started', color: 0xFF242331),
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
                                'Non-Skip Ads',
                                style: GoogleFonts.inter(
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
                                    style: GoogleFonts.inter(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    ' / lead',
                                    style: GoogleFonts.inter(
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
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      color: const Color(0xFFC68A15)),
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
                                'Advertisers benefit from guaranteed\nviewability and higher completion rates.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Users enjoy an incentivized rewards only for\nfull ad engagement. ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'If customer doesn’t see the ad, they don’t\nget money. There will be a pop up as shown.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Incentivized rewards for watching  full ad.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Viewer is paid 30% to view and 70% if\nthey like the video.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Interact with customers on voice app.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const LoginScreen())?.then((value) => {
                                        if (value != null)
                                          {
                                            Scrollable.ensureVisible(
                                                contactKey.currentContext!,
                                                duration: const Duration(
                                                    milliseconds: 300))
                                          }
                                      });
                                },
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const LoginScreen())?.then((value) =>
                                        {
                                          if (value != null)
                                            {
                                              Scrollable.ensureVisible(
                                                  contactKey.currentContext!,
                                                  duration: const Duration(
                                                      milliseconds: 300))
                                            }
                                        });
                                  },
                                  child: const RoundedButton(
                                      text: 'Get Started', color: 0xFF242331),
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
                                'QR Video Ads',
                                style: GoogleFonts.inter(
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
                                    style: GoogleFonts.inter(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    ' / lead',
                                    style: GoogleFonts.inter(
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
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      color: const Color(0xFFC68A15)),
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
                                'Bridge between offline and online\nmarketing efforts.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Versatility in application, suitable for\nvarious industries.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Convenient access to additional content.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Incentivized rewards for watching  full ad.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Interactive storytelling for deeper\naudience engagement.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Get database of users who have interacted with your ad.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'If the customer doesn’t view the ad,\nyour money spent will be refunded.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'If the customer is not entering their phone number\n'
                                'after scanning and is not a viewer,\nthe money will not be credited.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: const Color(0xFF797979)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const LoginScreen())?.then((value) => {
                                        if (value != null)
                                          {
                                            Scrollable.ensureVisible(
                                                contactKey.currentContext!,
                                                duration: const Duration(
                                                    milliseconds: 300))
                                          }
                                      });
                                },
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const LoginScreen())?.then((value) =>
                                        {
                                          if (value != null)
                                            {
                                              Scrollable.ensureVisible(
                                                  contactKey.currentContext!,
                                                  duration: const Duration(
                                                      milliseconds: 300))
                                            }
                                        });
                                  },
                                  child: const RoundedButton(
                                      text: 'Get Started', color: 0xFF242331),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Out team member will contact you after filling this form.',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(40),
                      height: 600,
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
                                height: 220,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/icons/email.png'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SelectableText(
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color(0xFFFD2120))),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/icons/phone.png'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SelectableText(
                                            '+91 81481471712',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await Utils.launchWeb(
                                            uri: Uri.parse(
                                                'https://www.google.com/maps/place/AdTip/@17.7231673,83.3250019,17z/data=!3m1!4b1!4m6!3m5!1s0x3a3943a988e2d721:0x2a61e920c4a01444!8m2!3d17.7231673!4d83.3250019!16s%2Fg%2F11vxttv598?entry=ttu'));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                              'assets/icons/location.png'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'AU South Campus,\nAndhra University,\nAndhra Pradesh, India,\nPincode:530003',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 228,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Utils.launchWeb(
                                              uri: Uri.parse(
                                                  StringConstants.fbLink));
                                        },
                                        child: Image.asset(
                                            'assets/icons/facebook.png')),
                                    InkWell(
                                      onTap: () {
                                        Utils.launchWeb(
                                            uri: Uri.parse(
                                                StringConstants.instLink));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xffFD2120),
                                        child: Image.asset(
                                            'assets/icons/insta.png'),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Utils.launchWeb(
                                              uri: Uri.parse(StringConstants
                                                  .linkedinLink));
                                        },
                                        child: Image.asset(
                                            'assets/icons/linkedin.png')),
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
                                          _selectedIndex =
                                              selected ? index : -1;
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Obx(() => landingController
                                                    .isLoading.value
                                                ? const CircularProgressIndicator()
                                                : InkWell(
                                                    onTap: () async {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        formKey.currentState!
                                                            .save();
                                                        await landingController
                                                            .submitWebsiteMessage(
                                                                name: name.text
                                                                    .trim(),
                                                                message: message
                                                                    .text
                                                                    .trim(),
                                                                mobile:
                                                                    phoneNumber
                                                                        .text
                                                                        .trim(),
                                                                type: categories[
                                                                    _selectedIndex]);
                                                        name.text = '';
                                                        phoneNumber.text = '';
                                                        message.text = '';
                                                        Utils.showDialogDemoVideo(
                                                            context: context,
                                                            videoLink:
                                                                StringConstants
                                                                    .bookAdDemo);
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                            'assets/icons/send.png'),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Send Message',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))),
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
                const SizedBox(
                  height: 20,
                ),

                ///faq
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    key: faqKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
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
                          title:
                              'What are the benefits of advertising with Adtip?',
                          subtitle:
                              'Advertising with Adtip not only reaches a targeted audience but also engages viewers more effectively by directly crediting money to their wallet, leading to higher ad retention and engagement rates.'),
                      FAQWidget(
                          title: 'Is my personal information safe with Adtip?',
                          subtitle:
                              'Yes, Adtip prioritizes the privacy and security of your personal information. We use advanced encryption and security protocols to protect your data. Please review our privacy policy for more details.'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Copyright © 2024 AdTip (OPC) pvt ltd.',
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
                              SelectableText(
                                '+91 81481471712',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SelectableText(
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
                              InkWell(
                                onTap: () {
                                  Scrollable.ensureVisible(
                                      homeKey.currentContext!,
                                      duration:
                                          const Duration(milliseconds: 300));
                                },
                                child: Text(
                                  'About Adtip',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Text(
                              //   'Blog',
                              //   style: GoogleFonts.inter(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.white),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  Scrollable.ensureVisible(
                                      contactKey.currentContext!,
                                      duration:
                                          const Duration(milliseconds: 300));
                                },
                                child: Text(
                                  'Contact Us',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Scrollable.ensureVisible(
                                      adModelKey.currentContext!,
                                      duration:
                                          const Duration(milliseconds: 300));
                                },
                                child: Text(
                                  'Ad Model Pricing',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Text(
                              //   'Clients',
                              //   style: GoogleFonts.inter(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.white),
                              // ),
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
                              Row(
                                children: [
                                  Text(
                                    'Help',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SelectableText(
                                    '+91 81481471712',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const TermsOfServiceText());
                                },
                                child: Text(
                                  'Terms of Service',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Text(
                              //   'Legal',
                              //   style: GoogleFonts.inter(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.white),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  Get.to(const PrivacyPolicyText());
                                },
                                child: Text(
                                  'Privacy Policy',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Utils.launchWeb(
                                      uri: Uri.parse(StringConstants.whatsapp));
                                },
                                child: Text(
                                  "WhatsApp",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              // Text(
                              //   'Status',
                              //   style: GoogleFonts.inter(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Stay up to date',
                          //       style: GoogleFonts.inter(
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.w600,
                          //           color: Colors.white),
                          //     ),
                          //     const SizedBox(
                          //       height: 20,
                          //     ),
                          //     SizedBox(
                          //       width: 300,
                          //       height: 100,
                          //       child: TextFormField(
                          //         decoration: InputDecoration(
                          //           hintText: 'Your email address',
                          //           hintStyle: GoogleFonts.inter(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.white),
                          //           border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10.0),
                          //             borderSide: const BorderSide(
                          //                 color: Colors.white, width: 2.0),
                          //           ),
                          //           suffixIcon:
                          //               Image.asset('assets/icons/send.png'),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // )
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
    });
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
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1AD4D9),
          ),
        ),
      ),
    );
  }
}

class FAQWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const FAQWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          softWrap: true,
          style: GoogleFonts.inter(fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class FAQWidgetMob extends StatelessWidget {
  final String title;
  final String subtitle;
  const FAQWidgetMob({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          softWrap: true,
          style: GoogleFonts.inter(fontSize: 12),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
