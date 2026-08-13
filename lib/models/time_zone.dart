class TimezoneData {
  final String timezone;
  final String localTime;
  final int utcOffset;

  TimezoneData({
    required this.timezone,
    required this.localTime,
    required this.utcOffset,
  });

  factory TimezoneData.fromJson(Map<String, dynamic> json) {
    return TimezoneData(
      timezone: json['timezone'],
      localTime: json['local_time'],
      utcOffset: json['current_utc_offset_seconds'],
    );
  }
}
