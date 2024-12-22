import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theming/colors.dart';
import '../../data/models/surah_details_model.dart';

class SurahDetailsItem extends StatefulWidget {
  const SurahDetailsItem({super.key, required this.data, required this.index});
  final Ayah data;
  final int index;

  @override
  State<SurahDetailsItem> createState() => _SurahDetailsItemState();
}

class _SurahDetailsItemState extends State<SurahDetailsItem> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  void _handleAudioPlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.data.audio));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = "";
    if (widget.data.numberInSurah == 1) {
      if (widget.index != 1 && widget.index != 9) {
        text = widget.data.text.substring(38, widget.data.text.length);
      } else {
        text = widget.data.text;
      }
    } else {
      text = widget.data.text;
    }

    return FadeInLeft(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage("assets/images/Star 1.png"),
                  radius: 22.r,
                  child: Text(
                    widget.data.numberInSurah.toString(), // Example number
                    style: GoogleFonts.amiri(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Share.share(
                      '${widget.data.text} ,  (${widget.data.numberInSurah})',
                    );
                  },
                  icon: Icon(
                    Icons.share,
                    size: 25.sp,
                    color: AppColors.textColor,
                  ),
                ),
                IconButton(
                  onPressed: _handleAudioPlayPause,
                  icon: Icon(
                    isPlaying ? Icons.pause_outlined : Icons.play_arrow,
                    size: 30.sp,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                text,
                style: GoogleFonts.amiri(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
