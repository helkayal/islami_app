import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/constants.dart';

import '../../../core/theming/colors.dart';
import '../../../islam_app.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const IslamAppMainScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset(
              'assets/images/splash_nobg.png',
              width: ScreenUtil().screenWidth,
              height: 250.h,
              fit: BoxFit.cover,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              'إسلاميات ',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding * 2),
              child: Text(
                "صديقك اليومي الذي يوفر لك أوقات الصلاة، الأذكار، تلاوة القرآن، اتجاه القبلة، والمزيد لمساعدتك في تعزيز عملك الديني بسهولة ويسر",
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
