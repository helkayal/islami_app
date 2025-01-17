import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/widgets/grdient_container.dart';
import '../../../prayer/ui/controller/prayer_times_cubit.dart';
import '../widgets/home_view_body.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndLoadTimes();
  }

  Future<void> _checkLocationPermissionAndLoadTimes() async {
    final prayerTimesCubit = context.read<PrayerTimesCubit>();

    // 1) Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() => _permissionDenied = true);
      return;
    }

    // 2) Check location permission
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

    // 3) If we reach here, permission is granted. Load prayer times.
    if (!mounted) return;
    prayerTimesCubit.loadPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionDenied) {
      return const Scaffold(
        body: GrdientContainer(
          child: Center(
            child: Text(
              'Location permission needed to display current prayer.\nPlease enable it in settings.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return const Scaffold(
      body: GrdientContainer(
        child: HomeScreenBody(),
      ),
    );
  }
}
