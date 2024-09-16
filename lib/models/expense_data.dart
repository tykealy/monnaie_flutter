class ExpenseData {
  late String id;
  final double amount;
  final String date;
  final String description;
  final String type;

  ExpenseData(
      {this.id = '',
      required this.amount,
      required this.date,
      required this.description,
      required this.type});
}
