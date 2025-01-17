import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
    required this.city,
    required this.country,
    required this.hijriDate,
    required this.gregorianDate,
  });

  final String city;
  final String country;
  final String hijriDate;
  final String gregorianDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/prayer_timing.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 12,
            top: 6.h,
            child: Text(
              '$city, $country',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                shadows: const [Shadow(blurRadius: 4, color: Colors.black26)],
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: SizedBox(
              width: ScreenUtil().screenWidth * .85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hijriDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    gregorianDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
