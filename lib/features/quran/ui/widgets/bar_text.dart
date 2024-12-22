import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BarText extends StatelessWidget {
  const BarText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.amiri(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
