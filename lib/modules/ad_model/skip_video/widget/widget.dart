import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customStyle({Color? color}) {
  return GoogleFonts.poppins(
      color: color ?? Colors.black,
      fontSize: 14.5,
      fontWeight: FontWeight.w400);
}
