class Weapon {
  final String name;
  final String type; // e.g., "Close Combat", "Ranged"
  final String range;
  final int ap;
  final List<String> keywords;

  Weapon({
    required this.name,
    required this.type,
    required this.range,
    required this.ap,
    required this.keywords,
  });
}