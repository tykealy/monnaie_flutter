import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/expense_data.dart';
import '../models/expense_firebase_data.dart';
import 'package:intl/intl.dart';

class ExpenseRecordService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<double> getExpenseRecordBasedOnType(String categoryId, int year,
      {int? week, int? month}) async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in.');
      }
      if (week != null) {
        QuerySnapshot querySnapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('categories')
            .doc(categoryId)
            .collection('expenses')
            .where('week', isEqualTo: week)
            .where('year', isEqualTo: year)
            .get();

        double totalAmount = 0;
        for (var doc in querySnapshot.docs) {
          totalAmount += (doc['amount'] ?? 0).toDouble();
        }
        return totalAmount;
      }
      if (month != null) {
        QuerySnapshot querySnapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('categories')
            .doc(categoryId)
            .collection('expenses')
            .where('month', isEqualTo: month)
            .where('year', isEqualTo: year)
            .get();

        double totalAmount = 0;
        for (var doc in querySnapshot.docs) {
          totalAmount += (doc['amount'] ?? 0).toDouble();
        }
        return totalAmount;
      }
    } catch (e) {
      throw Exception('Failed to get expense record: $e');
    }
    return 0;
  }

  Future<bool> saveExpense(ExpenseData expenseData) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in.');
    } else {
      try {
        final categoryId = expenseData.type;
        DateTime dateTime = parseDateTime(expenseData.date);
        int weekOfYear = getWeekOfYear(dateTime);
        int month = getMonth(dateTime);
        int year = getYear(dateTime);

        final expenseFirebase = ExpenseFirebaseData(
            amount: expenseData.amount,
            week: weekOfYear,
            month: month,
            year: year,
            date: dateTime,
            description: expenseData.description);

        DocumentReference docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('categories')
            .doc(categoryId);

        await docRef.collection('expenses').add({
          'amount': expenseFirebase.amount,
          'week': expenseFirebase.week,
          'month': expenseFirebase.month,
          'year': expenseFirebase.year,
          'date': expenseFirebase.date,
          'description': expenseFirebase.description,
        });
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  DateTime parseDateTime(String dateTimeString) {
    return DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeString);
  }

  int getWeekOfYear(DateTime date) {
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return (dayOfYear / 7).ceil();
  }

  int getMonth(DateTime dateTime) {
    return dateTime.month;
  }

  int getYear(DateTime dateTime) {
    return dateTime.year;
  }
}
