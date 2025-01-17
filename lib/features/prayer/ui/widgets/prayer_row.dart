import 'package:flutter/material.dart';

import '../../../../core/theming/constants.dart';

class PrayerRow extends StatelessWidget {
  const PrayerRow({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.isCurrent,
    required this.nextPrayerOffset,
  });

  final String prayerName;
  final String prayerTime;
  final bool isCurrent;
  final String? nextPrayerOffset;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isCurrent ? Colors.green.withOpacity(0.2) : Colors.transparent;
    final textColor = isCurrent ? Colors.black : Colors.grey[800];

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.defaultPadding * 1.5,
        horizontal: AppConstants.defaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayerTime,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
          Text(
            prayerName,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
