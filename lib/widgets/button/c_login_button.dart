import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';

class CLoginButton extends StatelessWidget {
  final String title;
  final String? image;
  final Color buttonColor;
  final Color textColor;
  final bool showImage;
  final double? height;
  final VoidCallback onTap;
  final bool isLoading;
  final double? radius;
  CLoginButton(
      {super.key,
      required this.title,
      this.image,
      this.isLoading = false,
      required this.buttonColor,
      required this.textColor,
      required this.showImage,
      required this.onTap,
      this.radius,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10)),
        elevation: 2.2,
        child: Container(
          height: height ?? 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // border: Border.all(color: AdtipColors.black),
              color: buttonColor,
              borderRadius: BorderRadius.circular(radius ?? 5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showImage == true)
                SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(image.toString())),
              const SizedBox(
                width: 10,
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      title,
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class CBackButton extends StatelessWidget {
  const CBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      padding: const EdgeInsets.only(left: 7),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: const Icon(
        Icons.arrow_back_ios,
        size: 20,
      ),
    );
  }
}
