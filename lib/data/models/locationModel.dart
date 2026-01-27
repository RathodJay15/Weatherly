class LocationModel {
  final String city;
  final String region;

  LocationModel({required this.city, required this.region});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(city: json['name'], region: json['region']);
  }
}
