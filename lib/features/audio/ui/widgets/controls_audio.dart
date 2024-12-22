import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';

class ControlsAudio extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const ControlsAudio({
    super.key,
    required this.audioPlayer,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.skip_previous_rounded),
          iconSize: 50.sp,
          color: AppColors.textColor,
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.onPlayerStateChanged,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data == PlayerState.playing;

            if (isPlaying) {
              return IconButton(
                onPressed: () async {
                  await audioPlayer.pause();
                },
                icon: const Icon(Icons.pause_rounded),
                iconSize: 50.sp,
                color: AppColors.textColor,
              );
            } else {
              return IconButton(
                onPressed: () async {
                  await audioPlayer.resume();
                },
                icon: const Icon(Icons.play_arrow_rounded),
                iconSize: 50.sp,
                color: AppColors.textColor,
              );
            }
          },
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.skip_next_rounded),
          iconSize: 50.sp,
          color: AppColors.textColor,
        ),
      ],
    );
  }
}
