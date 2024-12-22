import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';

class AzkarItem extends StatelessWidget {
  final String zkr;
  final int count;
  const AzkarItem({
    required this.zkr,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.defaultPadding,
          horizontal: AppConstants.defaultPadding * 1.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              zkr,
              style: GoogleFonts.amiri(
                fontSize: 20.sp,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.right,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage("assets/images/Star 1.png"),
                  radius: 14.r,
                  child: Text(
                    count.toString(),
                    style: GoogleFonts.amiri(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  ": مرات التكرار ",
                  style: GoogleFonts.amiri(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
      // Row(
      //   children: [
      //     const Spacer(),
      //     Text(
      //       zkr,
      //       style: GoogleFonts.amiri(
      //         fontSize: 24.sp,
      //         color: AppColors.textColor,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     const SizedBox(width: 15),
      //     CircleAvatar(
      //       backgroundColor: Colors.transparent,
      //       backgroundImage: const AssetImage("assets/images/Star 1.png"),
      //       radius: 22.r,
      //       child: Text(
      //         count.toString(),
      //         style: GoogleFonts.amiri(
      //           fontSize: 18.sp,
      //           fontWeight: FontWeight.w600,
      //           color: AppColors.textColor,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
