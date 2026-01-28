class LocationModel {
  final String? city;
  final String? region;
  final double? lat;
  final double? long;

  LocationModel({
    required this.city,
    required this.region,
    required this.lat,
    required this.long,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['name'],
      region: json['region'],
      lat: json['lat'],
      long: json['lon'],
    );
  }
}
