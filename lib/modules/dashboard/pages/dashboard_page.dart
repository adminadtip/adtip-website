import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/createCompany/page/your_companies_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../ad_model/ad_model.dart';
import '../../ad_model/page/order_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    Image.asset('assets/icons/home.png'),
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset('assets/icons/star.png'),
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset('assets/icons/calendar.png'),
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset('assets/icons/notification.png'),
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset('assets/icons/Chat.png'),
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset('assets/icons/Profile.png'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 44,
                      width: 267,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search anything in adtip',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 12,
                          ),
                          fillColor: const Color(0xFFF6F6F6),
                          suffixIcon: Container(
                            height: 44,
                            width: 61,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00ACFF),
                              borderRadius: BorderRadius.only(
                                // Top left corner
                                topRight:
                                    Radius.circular(20.0), // Top right corner

                                bottomRight: Radius.circular(
                                    20.0), // Bottom right corner
                              ),
                            ),
                            child: Center(
                              child: Image.asset('assets/icons/search.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          height: 120,
                          width: 278,
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            height: 82,
                            width: 278,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              color: Colors.grey,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw4UeEjjERyEVTOIaXIKHlj7snPZAKulH5-z1Kau1lsw&s'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(18),
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              color: Colors.black,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw4UeEjjERyEVTOIaXIKHlj7snPZAKulH5-z1Kau1lsw&s'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 85,
                          left: 60,
                          child: Text(
                            'Apple',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 60,
                          child: Text(
                            'Consumer Electronic',
                            style: GoogleFonts.roboto(
                                fontSize: 10, color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 278,
                      height: 1,
                      color: const Color(0xFFF6F6F6),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/Plus.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Create new company page',
                          style: GoogleFonts.roboto(
                              fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFFCFDFD),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              int? userId = LocalPrefs().getIntegerPref(
                                  key: SharedPreferenceKey.UserId);

                              Get.to(YourCompaniesPage(userId: userId ?? 0));
                            },
                            child: Text(
                              'My Company',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: const Color(0xFF666666)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const OrderListScreen());
                            },
                            child: Text(
                              'Ad Orders',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: const Color(0xFF666666)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Utils.showSuccessMessage(
                                  'This feature is under development');
                            },
                            child: Text(
                              'Ad Cart',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: const Color(0xFF666666)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Utils.showSuccessMessage(
                                  'This feature is under development');
                            },
                            child: Text(
                              'Wallet',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: const Color(0xFF666666)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Utils.showSuccessMessage(
                                  'This feature is under development');
                            },
                            child: Text(
                              'Passbook',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: const Color(0xFF666666)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 278,
                      child: ListTile(
                        title: Text(
                          'AD MODELS FOR YOU',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Creative ways to promote',
                          style: GoogleFonts.roboto(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color:
                                    Color(0xFFEB2949))), // Set the border color
                          ),
                          onPressed: () {
                            Get.to(AdModelScreen());
                          },
                          child: Text(
                            'View All',
                            style: GoogleFonts.roboto(
                                fontSize: 12, color: const Color(0xFFEB2949)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ad_widget(
                      imagePath: 'assets/icons/skip_ad.png',
                      title: 'Skip Ad Model',
                      subtitle: 'In between Ads',
                      function: () {},
                    ),
                    ad_widget(
                      imagePath: 'assets/icons/master_ad.png',
                      title: 'Skip Ad Model',
                      subtitle: 'In between Ads',
                      function: () {},
                    ),
                    ad_widget(
                      imagePath: 'assets/icons/qr_code.png',
                      title: 'Skip Ad Model',
                      subtitle: 'In between Ads',
                      function: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/try_ad_model.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 290,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color(0xFFD8C281),
                          Color(0xFFAC9B69),
                        ]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Adtip Premium',
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Special features only for premium users',
                            style: GoogleFonts.roboto(
                                fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFFCFDFD),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/icons/my_ads.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'My Ads',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/icons/my_products.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'My Products',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/icons/manage_admins.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Manage Admins',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xFF666666)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 215,
              width: Get.width,
              color: const Color(0xFFF7F9FB),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Navigation',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'About',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Career',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Advertising',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Small Business',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Ad Solutions',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Marketing Solutions',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Sales Business',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Help',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Community Guidelines',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Privacy & Terms',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Mobile App',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get our app now:',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'assets/images/googleplay_icon.png',
                            height: 47,
                            width: 163,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ad_widget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback function;
  const ad_widget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 275,
          height: 40,
          child: ListTile(
            leading: Image.asset(imagePath),
            title: Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 14, color: const Color(0xFF0A0A0A)),
            ),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.inter(
                  fontSize: 14, color: const Color(0xFF9F9BB9)),
            ),
            trailing: InkWell(
              onTap: function,
              child: Text(
                'Book',
                style: GoogleFonts.inter(
                    fontSize: 12, color: const Color(0xFF00ACFF)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 0.5,
          width: 275,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
