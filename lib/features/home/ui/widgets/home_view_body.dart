import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../data/models/feature_model.dart';
import 'feature_item.dart';
import 'last_read.dart';
import 'prayer_container.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding.w,
                vertical: AppConstants.defaultPadding.h,
              ),
              child: Text(
                DateFormat.yMMMMd('ar').format(DateTime.now()).toString(),
                // "الجمعه ، ٨ نوفمبر ٢٠٢٤",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            const PrayerContainer(),
            const LastReadSurah(),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: FeatureModel.features.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => FeatureItem(
                image: FeatureModel.features[index].image,
                title: FeatureModel.features[index].title,
                routeName: FeatureModel.features[index].routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
