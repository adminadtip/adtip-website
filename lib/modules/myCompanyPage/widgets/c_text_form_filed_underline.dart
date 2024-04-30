import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/asset_files.dart';

class CTextFormFiledUnderline extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final TextStyle? style;
  final int? maxLines;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CTextFormFiledUnderline(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.maxLines,
      this.style,
      this.validator,
      this.initialValue,
      this.keyboardType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: style ??
              GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 17),
        ),
        TextFormField(
            inputFormatters: inputFormatters,
            initialValue: initialValue,
            keyboardType: keyboardType,
            maxLines: maxLines,
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: InkWell(
                  onTap: controller?.clear,
                  child: Padding(
                    padding: EdgeInsets.only(right: 17),
                    child: Image.asset(
                      AdtipAssets.CLOSE_CIRCLE_ICON,
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
                hintStyle: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w400)),
            validator: validator),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
