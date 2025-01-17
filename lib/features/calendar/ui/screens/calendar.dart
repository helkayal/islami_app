import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/constants.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../widgets/month_calendar.dart';

class HijriCalendarScreen extends StatefulWidget {
  static const routeName = 'hijri_calendar';
  const HijriCalendarScreen({super.key});

  @override
  State<HijriCalendarScreen> createState() => _HijriCalendarScreenState();
}

class _HijriCalendarScreenState extends State<HijriCalendarScreen> {
  late HijriCalendar _hijriCalendar;
  final Map<String, int> _monthOffsets =
      {}; // Map to store offsets for each month

  @override
  void initState() {
    super.initState();
    HijriCalendar.setLocal("ar"); // Use Arabic locale
    _hijriCalendar =
        HijriCalendar.now(); // Initialize with the current Hijri date
    _applyOffset(); // Apply the initial offset
  }

  /// Generate a unique key for the current month and year
  String _getMonthKey(int year, int month) {
    return "$year-$month";
  }

  /// Apply the stored offset for the current month or inherit from the previous month
  void _applyOffset() {
    final monthKey = _getMonthKey(_hijriCalendar.hYear, _hijriCalendar.hMonth);

    // If the current month has no offset, inherit from the previous month
    if (!_monthOffsets.containsKey(monthKey)) {
      if (_hijriCalendar.hMonth == 1) {
        // If this is Muharram, no previous month; set to 0
        _monthOffsets[monthKey] = 0;
      } else {
        // Inherit the offset from the previous month
        final previousMonthKey = _getMonthKey(
          _hijriCalendar.hMonth == 1
              ? _hijriCalendar.hYear - 1
              : _hijriCalendar.hYear,
          _hijriCalendar.hMonth == 1 ? 12 : _hijriCalendar.hMonth - 1,
        );
        _monthOffsets[monthKey] = _monthOffsets[previousMonthKey] ?? 0;
      }
    }
  }

  /// Update the HijriCalendar instance and reinitialize for the current month
  void _updateHijriCalendar({required int year, required int month}) {
    setState(() {
      _hijriCalendar = HijriCalendar.fromDate(
        _hijriCalendar.hijriToGregorian(year, month, 1),
      );
      _applyOffset(); // Reapply the global offset for the new month
    });
  }

  /// Adjust the offset for the current month and apply it
  void _adjustStartDay(int offsetChange) {
    final monthKey = _getMonthKey(_hijriCalendar.hYear, _hijriCalendar.hMonth);

    setState(() {
      _monthOffsets[monthKey] = (_monthOffsets[monthKey] ?? 0) + offsetChange;
    });
  }

  /// Navigate to the previous Hijri month
  void _goToPreviousMonth() {
    if (_hijriCalendar.hMonth == 1) {
      _updateHijriCalendar(year: _hijriCalendar.hYear - 1, month: 12);
    } else {
      _updateHijriCalendar(
          year: _hijriCalendar.hYear, month: _hijriCalendar.hMonth - 1);
    }
  }

  /// Navigate to the next Hijri month
  void _goToNextMonth() {
    if (_hijriCalendar.hMonth == 12) {
      _updateHijriCalendar(year: _hijriCalendar.hYear + 1, month: 1);
    } else {
      _updateHijriCalendar(
          year: _hijriCalendar.hYear, month: _hijriCalendar.hMonth + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthKey = _getMonthKey(_hijriCalendar.hYear, _hijriCalendar.hMonth);
    final currentOffset = _monthOffsets[monthKey] ?? 0;

    return Scaffold(
      appBar: const CustomWidgetsAppBar(title: "التقويم الهجري"),
      body: GrdientContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              // Dynamic Month Name
              Text(
                "شهر ${_hijriCalendar.longMonthName} ${_hijriCalendar.hYear}",
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _goToPreviousMonth,
                    icon: const Icon(Icons.arrow_back,
                        size: 30, color: AppColors.textColor),
                  ),
                  IconButton(
                    onPressed: _goToNextMonth,
                    icon: const Icon(Icons.arrow_forward,
                        size: 30, color: AppColors.textColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Offset Adjustment Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _adjustStartDay(-1),
                    child: const Text("−1 يوم"),
                  ),
                  ElevatedButton(
                    onPressed: () => _adjustStartDay(1),
                    child: const Text("+1 يوم"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Full Hijri Month Calendar
              Expanded(
                child: MonthCalendar(
                  hijriCalendar: _hijriCalendar,
                  startOffset: currentOffset,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
