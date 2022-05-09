
class Castle {
  List<String>? religion;
  String name;
  String location;

  Castle({this.religion, required this.name, required this.location});

  factory Castle.fromJson(Map<String, dynamic> json) {
    return Castle(
      religion: List<String>.from(json["religion"].map((x) => x)),
      name: json['name'],
      location: json['location'] ?? 'Terra do nunca',
    );
  }

  @override
  String toString() {
    return 'Castle{religion: $religion, name: $name, location: $location}';
  }
}
