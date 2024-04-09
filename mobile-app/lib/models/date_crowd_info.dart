class DateCrowdInfo {
  final DateTime date;
  final int maxCap;
  final int bookedTickets;

  DateCrowdInfo({
    required this.date,
    required this.maxCap,
    required this.bookedTickets,
  });

  factory DateCrowdInfo.fromJson(Map<String, dynamic> json) {
    return DateCrowdInfo(
      date: DateTime.parse(json['date']),
      maxCap: json['maxCap'],
      bookedTickets: json['bookedTickets'],
    );
  }
}
