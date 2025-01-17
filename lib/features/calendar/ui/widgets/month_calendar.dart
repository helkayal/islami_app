import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../../core/theming/colors.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required HijriCalendar hijriCalendar,
    required this.startOffset,
  }) : _hijriCalendar = hijriCalendar;

  final HijriCalendar _hijriCalendar;
  final int startOffset;

  @override
  Widget build(BuildContext context) {
    // Get the number of days in the current Hijri month
    final daysInMonth = _hijriCalendar.getDaysInMonth(
      _hijriCalendar.hYear,
      _hijriCalendar.hMonth,
    );

    // List of day names (e.g., Sun, Mon, ...)
    const weekDays = [
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت"
    ];

    // Calculate the Gregorian date of the first day of the Hijri month with the applied offset
    final firstDayGregorian = _hijriCalendar.hijriToGregorian(
      _hijriCalendar.hYear,
      _hijriCalendar.hMonth,
      1,
    );

    // Calculate the weekday of the first day with the applied offset
    int firstWeekDay = (firstDayGregorian.weekday + startOffset - 1) % 7;

    // Current Hijri date
    final todayHijri = HijriCalendar.now();

    return Column(
      children: [
        // Weekday Headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: weekDays
              .map((day) => Expanded(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),

        // Month Days
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 7 days in a week
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: daysInMonth + firstWeekDay,
            itemBuilder: (context, index) {
              if (index < firstWeekDay) {
                // Empty cells before the first day of the month
                return const SizedBox.shrink();
              }

              // Hijri day number
              final hijriDay = index - firstWeekDay + 1;

              // Gregorian date for this day
              final gregorianDate = _hijriCalendar.hijriToGregorian(
                _hijriCalendar.hYear,
                _hijriCalendar.hMonth,
                hijriDay,
              );

              final gregorianDay = gregorianDate.day;
              final gregorianMonthName =
                  _getGregorianMonthName(gregorianDate.month);

              // Check if this is the current Hijri day in the current month
              final isCurrentDay = (_hijriCalendar.hYear == todayHijri.hYear &&
                  _hijriCalendar.hMonth == todayHijri.hMonth &&
                  hijriDay == todayHijri.hDay);

              return Container(
                decoration: BoxDecoration(
                  color: isCurrentDay
                      ? Colors.green
                          .withOpacity(0.1) // Highlight the current day
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isCurrentDay ? Colors.green : Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$hijriDay",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isCurrentDay ? Colors.green : Colors.black,
                      ),
                    ),
                    Text(
                      gregorianDay == 1
                          ? gregorianMonthName // Display the month name
                          : "$gregorianDay", // Otherwise, display the day number
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Returns the full name of a Gregorian month
  String _getGregorianMonthName(int month) {
    const months = [
      "يناير", // January
      "فبراير", // February
      "مارس", // March
      "أبريل", // April
      "مايو", // May
      "يونيو", // June
      "يوليو", // July
      "أغسطس", // August
      "سبتمبر", // September
      "أكتوبر", // October
      "نوفمبر", // November
      "ديسمبر" // December
    ];
    return months[month - 1];
  }
}
