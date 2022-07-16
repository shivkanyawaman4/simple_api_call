import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

BoxDecoration decorationBorder = const BoxDecoration(
    color: Colors.cyan,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomRight: Radius.circular(30),
    ));

BoxDecoration decorationBorder1 = const BoxDecoration(
    color: Colors.cyan,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomRight: Radius.circular(10),
    ));
    TextStyle bigText =   TextStyle(
    fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.workSans().fontFamily,
    );

TextStyle midText =   TextStyle(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.workSans().fontFamily,
    );
    TextStyle smallText =   TextStyle(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal,
        fontFamily: GoogleFonts.workSans().fontFamily,
    );
     TextStyle vSmallText =   TextStyle(
    fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal,
        fontFamily: GoogleFonts.workSans().fontFamily,
    );
