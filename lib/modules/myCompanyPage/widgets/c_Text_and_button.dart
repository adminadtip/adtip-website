import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CTextAndButton extends StatelessWidget {
  final String title;
  final String buttonName;
  final VoidCallback onTap;
  final Color? color;
  const CTextAndButton({
    super.key,
    required this.title,
    required this.buttonName,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color ?? Color.fromARGB(224, 0, 24, 66),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                buttonName,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
