class CategoryData {
  late String id;
  final String icon;
  final String name;
  final double budget;
  final String type;

  CategoryData({
    this.id = '',
    required this.icon,
    required this.name,
    required this.budget,
    required this.type,
  });
}