import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    super.key,
    required this.image,
    required this.title,
    this.routeName = "",
  });
  final String image;
  final String title;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: routeName == ""
          ? () {}
          : () {
              Navigator.of(context).pushNamed(routeName);
            },
      child: Column(
        children: [
          Container(
            width: 120.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.lightGrey,
              ),
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultRadius * 2),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultRadius * 3),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppConstants.textFontFamily,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
