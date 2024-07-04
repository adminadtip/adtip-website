import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopMenu extends StatelessWidget {
  final String name;
  final GlobalKey globalKey;
  const TopMenu({super.key, required this.name, required this.globalKey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final context = globalKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(context,
              duration: const Duration(milliseconds: 300));
        }
      },
      child: Text(
        name,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
