import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';
import '../../../helpers/constants/colors.dart';

AppBar appBar({String? title, bool? showIcon = true, Color? textColor}) {
  return AppBar(
    centerTitle: true,
    leading: InkWell(
      onTap: () {
        //Get.to(MyWalletScreen());
      },

      child: Padding(
      padding: EdgeInsets.only(left: 24.0),
      child: showIcon == true
          ? Image.asset(
              AdtipAssets.WALLET_BORDER_ICON,
              height: 20,
              width: 20,
            )
          : Offstage(),
      ),
    ),
      
    title: Text(
      title ?? 'Advertiser',
      style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textColor ?? AdtipColors.red),
    ),
    actions: showIcon == true
        ? [
            InkWell(
              child: SvgPicture.asset(
                "assets/svg/Notification Icon Group.svg",
                height: 24,
                width: 24,
              ),

              onTap: () {
                //Get.to(NotificationPage());
              }
            ),
            
            SizedBox(
              width: 5,
            ),

            Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: InkWell(
                child: Image.asset(
                  AdtipAssets.MESSAGE_ICON,
                  height: 24,
                  width: 24,
                ),
                onTap: () {
                 // Get.to(ScreenMessage());
                }
              ),
              
              
            )
          ]
        : [],
  );
}
