import 'package:flutter/material.dart';
import 'package:monnaie/models/category_data.dart';
import 'package:monnaie/service/category_service.dart';

class CategoryExpenseProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<CategoryData> _weeklyCategoriesWithExpenses = [];
  List<CategoryData> _monthlyCategoriesWithExpenses = [];
  bool _isLoading = true;

  List<CategoryData> get weeklyCategoriesWithExpenses =>
      _weeklyCategoriesWithExpenses;
  List<CategoryData> get monthlyCategoriesWithExpenses =>
      _monthlyCategoriesWithExpenses;

  bool get isLoading => _isLoading;

  Future<void> fetchCategories(String weekly) async {
    _isLoading = true;
    notifyListeners();

    final week = getWeekOfYear(DateTime.now());
    final month = getMonth(DateTime.now());
    final year = getYear(DateTime.now());

    weekly == 'Weekly'
        ? _weeklyCategoriesWithExpenses =
            await _categoryService.getCategoriesWithExpenses(year, week: week)
        : _monthlyCategoriesWithExpenses = await _categoryService
            .getCategoriesWithExpenses(year, month: month);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCategoryAndExpense() async {
    // Refetch categories
    fetchCategories('Weekly');
    fetchCategories('Monthly');
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
