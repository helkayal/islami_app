import 'package:flutter/material.dart';

import '../widgets/surah_list_view.dart';

class SuraScreen extends StatelessWidget {
  static const routeName = 'sura';
  const SuraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SurahListView();
  }
}
