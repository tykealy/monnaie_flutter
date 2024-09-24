import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class TotalExpenseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getTotal(String type) async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in.');
      }
      int month = getMonth(DateTime.now());
      int year = getYear(DateTime.now());
      // int week = getWeekOfYear(DateTime.now());
      if (type == "Monthly") {
        QuerySnapshot categorySnapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('categories')
            .get();

        double totalAmount = 0;
        for (var categoryDoc in categorySnapshot.docs) {
          String categoryId = categoryDoc.id;

          // Fetch expenses for the specified month and year for the current category
          QuerySnapshot expenseSnapshot = await firestore
              .collection('users')
              .doc(user.uid)
              .collection('categories')
              .doc(categoryId)
              .collection('expenses')
              .where('month', isEqualTo: month)
              .where('year', isEqualTo: year)
              .get();

          // Sum the expenses for the current category
          for (var expenseDoc in expenseSnapshot.docs) {
            totalAmount += (expenseDoc['amount'] ?? 0).toDouble();
          }
        }
        return totalAmount.toString();
      }
    } catch (e) {
      throw Exception('Failed to get expense record: $e');
    }
    return "0";
  }

  DateTime parseDateTime(String dateTimeString) {
    return DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeString);
  }

  // int getWeekOfYear(DateTime date) {
  //   DateTime firstDayOfYear = DateTime(date.year, 1, 1);
  //   int dayOfYear = date.difference(firstDayOfYear).inDays + 1;
  //   return (dayOfYear / 7).ceil();
  // }

  int getMonth(DateTime dateTime) {
    return dateTime.month;
  }

  int getYear(DateTime dateTime) {
    return dateTime.year;
  }
}
