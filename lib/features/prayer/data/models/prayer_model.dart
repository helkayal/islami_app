class PrayerTimeModel {
  final String name; // e.g. "Fajr"
  final DateTime dateTime; // e.g. 2024-01-06 05:30

  PrayerTimeModel({
    required this.name,
    required this.dateTime,
  });

  /// For displaying a 12-hour format time like "05:30 AM"
  String get formattedTime {
    final local = dateTime.toLocal();
    final hour = local.hour;
    final minute = local.minute.toString().padLeft(2, '0');
    final amPm = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '${hour12.toString().padLeft(2, '0')}:$minute $amPm';
  }
}
