
class DayActive{


  String? id;

  int? numDay;

  String? days;
  int? duration;
  bool? hasCome;
  String? date;
  String? timeStart;
  String? timeEnd;


  DayActive(this.id, this.numDay, this.days, this.duration, this.hasCome,
      this.date, this.timeStart, this.timeEnd);

  factory DayActive.fromJson(Map<dynamic, dynamic> json) {

    return DayActive(
        json['id'],

        json['numDay'] ?? 0,
        json['days'] ?? '',
        json['duration'] ?? 0,
        json['hasCome'] ?? false,
        json['date'],
        json['timeStart'] ?? '',
        json['timeEnd'] ??''
    );
  }
}