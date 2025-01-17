import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/theming/constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../../data/models/prayer_model.dart';
import '../controller/prayer_times_cubit.dart';
import '../controller/prayer_times_state.dart';
import '../widgets/prayer_row.dart';
import '../widgets/top_card.dart';

class PrayerTimesScreen extends StatefulWidget {
  static const routeName = 'prayer_times';
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndLoadTimes();
  }

  Future<void> _checkLocationPermissionAndLoadTimes() async {
    final prayerTimesCubit = context.read<PrayerTimesCubit>();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() => _permissionDenied = true);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        setState(() => _permissionDenied = true);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() => _permissionDenied = true);
      return;
    }

    if (!mounted) return;
    prayerTimesCubit.loadPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionDenied) {
      return const Scaffold(
        appBar: CustomWidgetsAppBar(title: "مواقيــــت الصلاة"),
        body: GrdientContainer(
          child: Center(
            child: Text(
              'Location permission is required to show prayer times.\nPlease enable it in settings.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomWidgetsAppBar(title: "مواقيــــت الصلاة"),
      body: GrdientContainer(
        child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
          builder: (context, state) {
            if (state is PrayerTimesLoading || state is PrayerTimesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PrayerTimesLoaded) {
              final prayers = state.prayers;
              if (prayers.isEmpty) {
                return const Center(child: Text('No prayer times available.'));
              }

              // Grab city, country, hijri/greg date from state
              final city = state.city;
              final country = state.country;
              final hijriDate = state.hijriDate;
              final gregorianDate = state.gregorianDate;

              // Current prayer logic
              final currentPrayer = _findCurrentPrayer(prayers);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // top card
                    TopCard(
                        city: city,
                        country: country,
                        hijriDate: hijriDate,
                        gregorianDate: gregorianDate),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding * 3),
                      child: Column(
                        children: List.generate(prayers.length, (index) {
                          final p = prayers[index];
                          final isCurrent = (currentPrayer?.name == p.name);
                          return PrayerRow(
                              prayerName: p.name,
                              prayerTime: formatTimeArabic(p.dateTime),
                              isCurrent: isCurrent,
                              nextPrayerOffset: isCurrent
                                  ? _calculateNextPrayerOffset(prayers, index)
                                  : null);
                        }),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PrayerTimesError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  /// find last prayer whose dateTime <= now
  PrayerTimeModel? _findCurrentPrayer(List<PrayerTimeModel> prayers) {
    final now = DateTime.now();
    PrayerTimeModel? current;
    for (final p in prayers) {
      if (p.dateTime.isBefore(now) || p.dateTime.isAtSameMomentAs(now)) {
        current = p;
      }
    }
    if (current == null && prayers.isNotEmpty) {
      current = prayers.first;
    }
    return current;
  }

  /// calculates time offset for the next prayer if current
  String _calculateNextPrayerOffset(
    List<PrayerTimeModel> prayers,
    int currentIndex,
  ) {
    if (currentIndex < prayers.length - 1) {
      final now = DateTime.now().toLocal();
      final next = prayers[currentIndex];
      final diff = next.dateTime.toLocal().difference(now);
      if (diff.inMinutes > 0) {
        final hh = diff.inHours.remainder(24).toString().padLeft(2, '0');
        final mm = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
        return '$hh:$mm';
      }
    }
    return '--:--';
  }
}
