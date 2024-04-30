import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../helpers/constants/colors.dart';

class CTitleText extends StatelessWidget {
  final String title;
  final bool color;
  const CTitleText({super.key, required this.title, this.color = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: color == false ? AdtipColors.black : AdtipColors.lightPurple),
      textAlign: TextAlign.center,
    );
  }
}

class CSubTitleText extends StatelessWidget {
  final String subTitle;
  final TextAlign textAlign;
  final bool color;

  const CSubTitleText(
      {super.key,
      required this.subTitle,
      required this.textAlign,
      this.color = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color == false ? AdtipColors.textClr : AdtipColors.darkPurple),
      textAlign: textAlign,
    );
  }
}
