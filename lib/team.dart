class Team {
  late int id;
  late String abbreviation;
  late String city;
  late String conference;
  late String division;
  late String fullName;
  late String name;

  Team(
      {required this.id,
      required this.abbreviation,
      required this.city,
      required this.conference,
      required this.division,
      required this.fullName,
      required this.name});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbreviation = json['abbreviation'];
    city = json['city'];
    conference = json['conference'];
    division = json['division'];
    fullName = json['full_name'];
    name = json['name'];
  }
}
