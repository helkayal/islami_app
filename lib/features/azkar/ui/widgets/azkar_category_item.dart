import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theming/colors.dart';

class AzkarCategoryItem extends StatelessWidget {
  final String title;
  final int index;
  const AzkarCategoryItem({
    required this.title,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Row(
        children: [
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.amiri(
              fontSize: 24.sp,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/images/Star 1.png"),
            radius: 22.r,
            child: Text(
              index.toString(),
              style: GoogleFonts.amiri(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
