class Place {
  final String placeId;
  final String name;
  final double lat;
  final double lng;
  final String address;
  final String? type;

  Place({
    required this.placeId,

    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
    this.type,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      name: json['name'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      address: json['vicinity'] ?? '',
      type: json['types'] != null && json['types'].isNotEmpty
          ? json['types'][0]
          : null,
    );
  }
}
