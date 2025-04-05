class Gym {
  final int id;
  final String documentId;
  final String name;
  final double lat;
  final double long;
  final String? description;

  Gym({
    required this.id,
    required this.documentId,
    required this.name,
    required this.lat,
    required this.long,
    this.description,
  });
}