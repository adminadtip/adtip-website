import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/colors.dart';

class CBorderButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CBorderButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 35,
          width: 189,
          decoration: BoxDecoration(border: Border.all()),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AdtipColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
