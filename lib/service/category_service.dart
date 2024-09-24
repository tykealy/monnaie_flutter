import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/category_data.dart';
import './expense_record_service.dart';

class CategoryService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<CategoryData>> getCategories() async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('categories')
          .get();

      final categories = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CategoryData(
          id: doc.id,
          icon: data['icon'] ?? '',
          name: data['name'] ?? '',
          budget: (data['budgeted'] ?? 0).toDouble(),
          type: data['type'] ?? '',
        );
      }).toList();
      return categories;
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveCategories(
      List<CategoryData> categories, List<String> deletedCategoryIds) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in.');
    } else {
      try {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        CollectionReference categoriesRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('categories');

        for (CategoryData category in categories) {
          String categoryId =
              category.id.isNotEmpty ? category.id : categoriesRef.doc().id;
          DocumentReference docRef = categoriesRef.doc(categoryId);
          batch.set(docRef, {
            'icon': category.icon,
            'name': category.name,
            'budgeted': category.budget,
            'type': category.type,
          });
        }

        for (String categoryId in deletedCategoryIds) {
          DocumentReference docRef = categoriesRef.doc(categoryId);
          batch.delete(docRef);
        }

        await batch.commit();
        return true;
      } catch (e) {
        throw Exception('Failed to save categories: $e');
      }
    }
  }

  Future<List<CategoryData>> getCategoriesWithExpenses(int year,
      {int? week, int? month}) async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('categories')
          .get();

      final categories = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CategoryData(
          id: doc.id,
          icon: data['icon'] ?? '',
          name: data['name'] ?? '',
          budget: (data['budgeted'] ?? 0).toDouble(),
          type: data['type'] ?? '',
        );
      }).toList();

      ExpenseRecordService expenseRecordService = ExpenseRecordService();

      for (CategoryData category in categories) {
        if (week != null) {
          double expense =
              await expenseRecordService.getExpenseRecordBasedOnType(
            category.id,
            year,
            week: week,
          );
          category.expense = expense;
        }
        if (month != null) {
          double expense =
              await expenseRecordService.getExpenseRecordBasedOnType(
            category.id,
            year,
            month: month,
          );
          category.expense = expense;
        }
      }
      return categories; // Add return statement here
    } catch (e) {
      return [];
    }
  }

  Stream<List<CategoryData>> getCategoriesWithExpensesStream(int year,
      {int? week, int? month}) {
    ExpenseRecordService expenseRecordService = ExpenseRecordService();
    User? user = auth.currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in.');
    }
    var query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid) // Replace with actual user ID
        .collection('categories');

    // Stream of Firestore documents
    return query.snapshots().asyncMap((snapshot) async {
      List<CategoryData> categories = snapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryData(
          id: doc.id,
          icon: data['icon'] ?? '',
          name: data['name'] ?? '',
          budget: (data['budgeted'] ?? 0).toDouble(),
          type: data['type'] ?? '',
        );
      }).toList();

      // For each category, fetch and update the expense based on week or month
      for (CategoryData category in categories) {
        if (week != null) {
          double expense =
              await expenseRecordService.getExpenseRecordBasedOnType(
            category.id,
            year,
            week: week,
          );
          category.expense = expense; // Update category with weekly expense
        } else if (month != null) {
          double expense =
              await expenseRecordService.getExpenseRecordBasedOnType(
            category.id,
            year,
            month: month,
          );
          category.expense = expense; // Update category with monthly expense
        }
      }
      return categories; // Return the updated list of categories
    });
  }
}
