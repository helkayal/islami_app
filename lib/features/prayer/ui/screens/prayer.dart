import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/grdient_container.dart';
import '../../data/models/prayer_model.dart';
import '../controller/prayer_times_cubit.dart';
import '../controller/prayer_times_state.dart';

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
                    _buildTopCard(
                      city: city,
                      country: country,
                      hijriDate: hijriDate,
                      gregorianDate: gregorianDate,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: List.generate(prayers.length, (index) {
                          final p = prayers[index];
                          final isCurrent = (currentPrayer?.name == p.name);
                          return _buildPrayerRow(
                            prayerName: p.name,
                            prayerTime: p.formattedTime,
                            isCurrent: isCurrent,
                            nextPrayerOffset: isCurrent
                                ? _calculateNextPrayerOffset(prayers, index)
                                : null,
                          );
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

  /// top card to show city/country & hijri/greg dates
  Widget _buildTopCard({
    required String city,
    required String country,
    required String hijriDate,
    required String gregorianDate,
  }) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hijriDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gregorianDate,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// single row for each prayer
  Widget _buildPrayerRow({
    required String prayerName,
    required String prayerTime,
    required bool isCurrent,
    String? nextPrayerOffset,
  }) {
    final bgColor =
        isCurrent ? Colors.green.withOpacity(0.2) : Colors.transparent;
    final textColor = isCurrent ? Colors.black : Colors.grey[800];

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              prayerName,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                prayerTime,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (nextPrayerOffset != null)
                Text(
                  'Up next $nextPrayerOffset',
                  style: const TextStyle(
                    color: Color(0xFF19611B),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          // const SizedBox(width: 8),
          // IconButton(
          //   icon: const Icon(Icons.alarm),
          //   onPressed: () {
          //     // handle notifications
          //   },
          // ),
        ],
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
      List<PrayerTimeModel> prayers, int currentIndex) {
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';

// import '../../../../core/widgets/custom_app_bar.dart';
// import '../../../../core/widgets/grdient_container.dart';
// import '../../data/models/prayer_model.dart';
// import '../controller/prayer_times_cubit.dart';
// import '../controller/prayer_times_state.dart';

// class PrayerTimesScreen extends StatefulWidget {
//   static const routeName = 'prayer_times';
//   const PrayerTimesScreen({super.key});

//   @override
//   State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
// }

// class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
//   bool _permissionDenied = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkLocationPermissionAndLoadTimes();
//   }

//   Future<void> _checkLocationPermissionAndLoadTimes() async {
//     final prayerTimesCubit = context.read<PrayerTimesCubit>();

//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       if (!mounted) return;
//       setState(() => _permissionDenied = true);
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         if (!mounted) return;
//         setState(() => _permissionDenied = true);
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       if (!mounted) return;
//       setState(() => _permissionDenied = true);
//       return;
//     }

//     if (!mounted) return;
//     prayerTimesCubit.loadPrayerTimes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_permissionDenied) {
//       return const Scaffold(
//         appBar: CustomWidgetsAppBar(
//           title: "مواقيــــت الصلاة",
//         ),
//         body: GrdientContainer(
//           child: Center(
//             child: Text(
//               'Location permission needed for prayer times.\nGrant permission in settings.',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: const CustomWidgetsAppBar(title: "مواقيــــت الصلاة"),
//       body: GrdientContainer(
//         child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
//           builder: (context, state) {
//             if (state is PrayerTimesLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is PrayerTimesLoaded) {
//               final prayers = state.prayers;
//               if (prayers.isEmpty) {
//                 return const Center(
//                   child: Text('No prayer times available.'),
//                 );
//               }

//               // 1) Figure out which prayer is currently ongoing
//               final currentPrayer = _findCurrentPrayer(prayers);

//               // 2) Build the screen with a top card & prayers list
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // TOP CARD: City, Country, Hijri & Gregorian dates
//                     _buildTopCard(
//                       city: 'Cairo',
//                       country: 'Egypt',
//                       hijriDate: '24 - جمادى الآخرة - 1445',
//                       gregorianDate: '06-January-2024',
//                     ),
//                     // List of Prayers
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Column(
//                         children: [
//                           for (int i = 0; i < prayers.length; i++)
//                             _buildPrayerRow(
//                               // Each item from your model
//                               prayerName: prayers[i].name,
//                               prayerTime: prayers[i].formattedTime,
//                               // or your own function to format
//                               isCurrent: currentPrayer?.name == prayers[i].name,
//                               // show "Up next HH:MM" if it's the current prayer
//                               nextPrayerOffset:
//                                   (currentPrayer?.name == prayers[i].name)
//                                       ? _calculateNextPrayerOffset(prayers, i)
//                                       : null,
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is PrayerTimesError) {
//               return Center(
//                 child: Text(
//                   'Error: ${state.message}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // ---- Helper Widgets & Methods ----

//   /// Builds the top banner/card (like in the reference image)
//   Widget _buildTopCard({
//     required String city,
//     required String country,
//     required String hijriDate,
//     required String gregorianDate,
//   }) {
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       height: 140.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         image: const DecorationImage(
//           image: AssetImage('assets/images/prayer_timing.png'),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 12,
//             top: 12,
//             child: Text(
//               '$city, $country',
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 12,
//             bottom: 12,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   hijriDate,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   gregorianDate,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                     shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPrayerRow({
//     required String prayerName,
//     required String prayerTime,
//     required bool isCurrent,
//     String? nextPrayerOffset,
//   }) {
//     final rowColor =
//         isCurrent ? Colors.green.withOpacity(0.2) : Colors.transparent;
//     final textColor = isCurrent ? Colors.black : Colors.grey[800];

//     return Container(
//       color: rowColor,
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               prayerName,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 prayerTime,
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               if (nextPrayerOffset != null)
//                 Text(
//                   'Up next $nextPrayerOffset',
//                   style: const TextStyle(
//                     color: Colors.green,
//                     fontSize: 12,
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   PrayerTimeModel? _findCurrentPrayer(List<PrayerTimeModel> prayers) {
//     final now = DateTime.now().toLocal();
//     PrayerTimeModel? current;

//     for (final p in prayers) {
//       if (p.dateTime.isBefore(now) || p.dateTime.isAtSameMomentAs(now)) {
//         current = p;
//       }
//     }

//     if (current == null && prayers.isNotEmpty) {
//       current = prayers.first;
//     }
//     return current;
//   }

//   String _calculateNextPrayerOffset(
//       List<PrayerTimeModel> prayers, int currentIndex) {
//     if (currentIndex < prayers.length - 1) {
//       final now = DateTime.now();
//       final nextPrayer = prayers[currentIndex + 1];
//       final diff = nextPrayer.dateTime.difference(now);
//       if (diff.inMinutes > 0) {
//         final hours = diff.inHours.remainder(24).toString().padLeft(2, '0');
//         final minutes = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
//         return '$hours:$minutes';
//       }
//     }
//     return '--:--';
//   }
// }
