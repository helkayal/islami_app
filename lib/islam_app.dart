import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/audio/ui/controller/recitation_cubit/recitation_cubit.dart';

import 'core/theming/colors.dart';
import 'features/audio/data/repos/recitations_repo_impl.dart';
import 'features/audio/ui/screens/audio.dart';
import 'features/home/ui/screens/home.dart';

import 'features/settings/ui/settings.dart';

class IslamAppMainScreen extends StatefulWidget {
  static const String routeName = 'islam_app_main_screen';
  const IslamAppMainScreen({super.key});

  @override
  State<IslamAppMainScreen> createState() => _IslamAppMainScreenState();
}

class _IslamAppMainScreenState extends State<IslamAppMainScreen> {
  int currentIndex = 2;

  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const SettingsScreen(),
      BlocProvider(
        create: (context) => RecitationCubit(
          RecitationsRepoImpl(),
        ),
        child: const AudioScreen(),
      ),
      const HomeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 20,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 0 ? Icons.settings : Icons.settings_outlined,
              ),
              label: 'الإعدادات ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 1
                    ? Icons.audiotrack
                    : Icons.audiotrack_outlined,
              ),
              label: 'صوتيات',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 2 ? Icons.home_filled : Icons.home_outlined,
              ),
              label: 'الرئسيه',
            ),
          ],
        ),
      ),
    );
  }
}
