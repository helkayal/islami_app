import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';

import '../../../../core/theming/constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../prayer/data/models/prayer_model.dart';
import '../../../prayer/ui/controller/prayer_times_cubit.dart';
import '../../../prayer/ui/controller/prayer_times_state.dart';

class PrayerContainer extends StatelessWidget {
  const PrayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        builder: (context, state) {
          if (state is PrayerTimesLoading || state is PrayerTimesInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerTimesLoaded) {
            final currentPrayer = _findCurrentPrayer(state.prayers);
            if (currentPrayer == null) {
              return const Center(child: Text("No current prayer right now."));
            }

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding * 2.w,
                vertical: AppConstants.defaultPadding.h,
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultMargin,
                  vertical: AppConstants.defaultMargin),
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff35F8A6),
                    Color(0xff6877FF),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/qibla.png',
                    fit: BoxFit.cover,
                    height: 70.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'صلاه ${currentPrayer.name}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                            ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        formatTimeArabic(currentPrayer.dateTime),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.whiteColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            // Center(
            //   child: Container(
            //     margin: const EdgeInsets.all(16.0),
            //     padding: const EdgeInsets.all(16.0),
            //     decoration: BoxDecoration(
            //       color: Colors.green.withOpacity(0.1),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Text(
            //       'Current Prayer:\n${currentPrayer.name} at ${currentPrayer.formattedTime}',
            //       style: const TextStyle(fontSize: 18),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // );
          } else if (state is PrayerTimesError) {
            return Center(
              child: Text('Error: ${state.message}',
                  style: const TextStyle(color: Colors.red)),
            );
          } else {
            // Fallback for unexpected states
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  PrayerTimeModel? _findCurrentPrayer(List<PrayerTimeModel> prayers) {
    final now = DateTime.now();
    PrayerTimeModel? current;
    for (final p in prayers) {
      if (p.dateTime.isBefore(now) || p.dateTime.isAtSameMomentAs(now)) {
        current = p;
      }
    }
    return current;
  }
}
