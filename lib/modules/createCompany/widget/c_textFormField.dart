// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/constants/colors.dart';

class CTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  Function(String val) callBack;
  final String? Function(String?)? validatorForm;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textController;
  final Widget? suffixWidget;
  final String? errorMessage;
  final int? maxLenght;
  final String? labelText;

  CTextFormField({
    super.key,
    required this.hintText,
    required this.callBack,
    this.keyboardType = TextInputType.text,
    this.validatorForm,
    this.initialValue,
    this.inputFormatters,
    this.textController,
    this.suffixWidget,
    this.errorMessage,
    this.maxLenght,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? '',
          style:
              GoogleFonts.inter(fontSize: 14, color: const Color(0xFF181E25)),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          // height: 55.h,
          width: 390,
          padding: EdgeInsets.zero,
          child: Theme(
            data: ThemeData(cardColor: AdtipColors.white),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(
                  color: Color(0xFFDEE4ED),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            maxLength: maxLenght,
                            controller: textController,
                            inputFormatters: inputFormatters,
                            initialValue: initialValue,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            onChanged: callBack,
                            validator: validatorForm,
                            decoration: InputDecoration(
                                suffixIcon: suffixWidget,
                                border: InputBorder.none,
                                hintText: hintText,
                                hintStyle: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF788BA5))),
                            keyboardType: keyboardType,
                            maxLines: 1,
                          ),
                          errorMessage != null
                              ? Text(
                                  errorMessage!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AdtipColors.red),
                                )
                              : const Offstage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
