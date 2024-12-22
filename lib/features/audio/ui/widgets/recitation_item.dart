import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../quran/ui/controller/surah_cubit/quran_cubit.dart';
import '../../data/models/recitation.dart';
import '../screens/surah_audio_view.dart';

class RecitationsItem extends StatefulWidget {
  const RecitationsItem({super.key, required this.recitation});
  final Recitation recitation;

  @override
  State<RecitationsItem> createState() => _RecitationsItemState();
}

class _RecitationsItemState extends State<RecitationsItem> {
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).getSurahs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SurahAudioView.routeName,
            arguments: widget.recitation);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          color: Color.fromARGB(255, 74, 16, 141),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Recitation
                        .styleTranslations[widget.recitation.style ?? 'مرتل'] ??
                    widget.recitation.style ??
                    'مرتل',
                style: GoogleFonts.amiri(
                  fontSize: 22.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.recitation.translatedName ??
                    widget.recitation.reciterName ??
                    '',
                style: GoogleFonts.amiri(
                  fontSize: 25.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
