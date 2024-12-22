import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class GrdientContainer extends StatelessWidget {
  final Widget child;
  const GrdientContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.lightPurple,
            AppColors.lightPurple,
            AppColors.whiteColor,
            AppColors.whiteColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
