class ExpenseFirebaseData {
  late String id;
  final double amount;
  final int week;
  final int month;
  final int year;
  final DateTime date;
  final String description;

  ExpenseFirebaseData(
      {this.id = '',
      required this.amount,
      required this.week,
      required this.month,
      required this.year,
      required this.date,
      required this.description});
}
