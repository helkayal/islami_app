class FeatureModel {
  final String title;
  final String image;
  final String routeName;

  const FeatureModel({
    required this.title,
    required this.image,
    this.routeName = '',
  });
  static List<FeatureModel> features = [
    const FeatureModel(
      title: 'الأذكار',
      image: 'assets/images/azkar.png',
      routeName: 'azkar_categories',
    ),
    const FeatureModel(
      title: 'القرآن الكريم',
      image: 'assets/images/quran.png',
      routeName: 'quran_home',
    ),
    const FeatureModel(
      title: 'القبله',
      image: 'assets/images/qibla1.png',
    ),
    const FeatureModel(
      title: ' مواقيت الصلاة ',
      image: 'assets/images/prayer_time.png',
    ),
    const FeatureModel(
      title: 'أحاديث',
      image: 'assets/images/hadith.png',
    ),
    const FeatureModel(
      title: ' أسماء الله الحسنى',
      image: 'assets/images/asmaaAllah.png',
    ),
  ];
}
