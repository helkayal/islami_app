import 'package:flutter/material.dart';

import '../../../core/widgets/grdient_container.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = 'settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GrdientContainer(
        child: Center(
          child: Text('صفحة الإعدادات '),
        ),
      ),
    );
  }
}
