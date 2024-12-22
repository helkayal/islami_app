import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami_app/features/quran/data/models/quran_model.dart';
import 'package:islami_app/features/quran/ui/controller/surah_cubit/quran_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../data/models/recitation.dart';
import '../controller/surah_audio_cubit/surah_audio_cubit.dart';
import '../widgets/controls_audio.dart';
import '../widgets/surah_audio_container.dart';
import '../widgets/surah_audio_list_view.dart';

class SurahAudioView extends StatefulWidget {
  const SurahAudioView({
    super.key,
  });
  static const routeName = '/surah_audio_view';

  @override
  State<SurahAudioView> createState() => _SurahAudioViewState();
}

class _SurahAudioViewState extends State<SurahAudioView> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  bool isAudioLoaded = false;
  String? audioUrl;
  int currentSurahIndex = 0; // To track the current surah
  List<QuranModel> surahs = [];
  Recitation? recitation;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (recitation == null) {
      // Prevent reinitializing if already set
      recitation = ModalRoute.of(context)!.settings.arguments as Recitation;
      BlocProvider.of<QuranCubit>(context).getSurahs();
      surahs = BlocProvider.of<QuranCubit>(context).surahList;
      if (surahs.isNotEmpty) {
        currentSurahIndex = surahs[0].number! - 1;
        fetchSurahAudio();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((Duration newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((Duration newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  void fetchSurahAudio() {
    final surah =
        surahs[currentSurahIndex]; // Get surah by index from surahList
    BlocProvider.of<SurahAudioCubit>(context).fetchSurahAudio(
      reciterId: recitation!.id.toString(),
      chapterId: surah.number.toString(),
    );
  }

  void handlePreviousSurah() {
    setState(() {
      // Wrap around if index is less than 0
      currentSurahIndex =
          (currentSurahIndex - 1 + surahs.length) % surahs.length;
      isAudioLoaded = false;
      fetchSurahAudio();
    });
  }

  void handleNextSurah() {
    setState(() {
      // Wrap around if index exceeds list length
      currentSurahIndex = (currentSurahIndex + 1) % surahs.length;
      isAudioLoaded = false;
      fetchSurahAudio();
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void handleSurahTap(int index) {
    setState(() {
      currentSurahIndex = index; // Update the selected Surah index
      isAudioLoaded = false; // Reset the audio loaded state
      fetchSurahAudio(); // Fetch the audio for the selected Surah
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9E5FF),
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
        title: Text(
          'القاريء ${recitation!.translatedName ?? recitation!.reciterName ?? ''}',
          style: GoogleFonts.amiri(
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 74, 16, 141),
        centerTitle: true,
      ),
      body: BlocBuilder<SurahAudioCubit, SurahAudioState>(
        builder: (context, state) {
          if (state is SurahAudioLoading) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.textColor,
                size: 50,
              ),
            );
          } else if (state is SurahAudioLoaded) {
            audioUrl = state.surahAudio.audioUrl;
            if (audioUrl != null && !isAudioLoaded) {
              audioPlayer.setSourceUrl(audioUrl!);

              isAudioLoaded = true;
            }
            return buildUiWidget();
          } else if (state is SurahAudioError) {
            return CustomErrorWidget(error: state.errMessage);
          } else {
            return const Center(
              child: Text("No audio available"),
            );
          }
        },
      ),
    );
  }

  Widget buildUiWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Column(
        children: [
          SurahAudioContainer(
            surah: surahs[currentSurahIndex],
          ),
          const SizedBox(height: 15),
          Slider(
            activeColor: AppColors.textColor,
            inactiveColor: AppColors.textColor.withOpacity(.5),
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final newPosition = Duration(seconds: value.toInt());
              await audioPlayer.seek(newPosition);
              setState(() {
                position = newPosition;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(position),
                  style: GoogleFonts.amiri(
                    color: Colors.deepPurple,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  formatTime(duration),
                  style: GoogleFonts.amiri(
                    color: Colors.deepPurple,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          ControlsAudio(
            audioPlayer: audioPlayer,
            onPrevious: handlePreviousSurah,
            onNext: handleNextSurah,
          ),
          Expanded(
            child: SurahAudioListView(
              surahs: surahs,
              onSurahTap: handleSurahTap,
            ),
          )
        ],
      ),
    );
  }
}
