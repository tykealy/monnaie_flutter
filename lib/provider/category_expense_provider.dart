import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monnaie/models/category_data.dart';
import 'package:monnaie/service/category_service.dart';
import 'package:monnaie/service/total_expense_service.dart';

class CategoryExpenseProvider with ChangeNotifier {
  double _totalSpent = 0;
  double get totalSpent => _totalSpent;

  int _addedCategoryNumber = 0;
  List _weeklyCategoryExpenses = [];
  List get weeklyCategoryExpenses => _weeklyCategoryExpenses;

  List _monthlyCategoryExpenses = [];
  List get monthlyCategoryExpenses => _monthlyCategoryExpenses;

  List<CategoryData> _initialCategories = [];
  final List<String> _initialDeletedCategoryIds = [];
  List<CategoryData> _categories = [];
  List<CategoryData> get categories => _categories;

  final List<String> _deletedCategoryIds = [];
  List<String> get deletedCategoryIds => _deletedCategoryIds;

  Future<void> fetchTotalExpense() async {
    double fetchedTotal = await TotalExpenseService().getTotal("Monthly");
    _totalSpent = fetchedTotal;
    notifyListeners();
  }

  void removeAddedCategory() {
    if (_addedCategoryNumber == 0) return;
    _categories.removeRange(0, _addedCategoryNumber);
    _addedCategoryNumber = 0;
    notifyListeners();
  }

  void deleteCategory(int index) {
    _deletedCategoryIds.add(_categories[index].id);
    _categories.removeAt(index);
    notifyListeners();
  }

  bool hasChanges() {
    _categories.removeWhere((category) => category.name.isEmpty);
    _deletedCategoryIds.removeWhere((id) => id.isEmpty);
    return !const Equality().equals(_categories, _initialCategories) ||
        !const Equality()
            .equals(_deletedCategoryIds, _initialDeletedCategoryIds);
  }

  void addCategory() {
    _categories.insert(
        0,
        CategoryData(
          icon: '🍔',
          name: 'New Category',
          budget: 50,
          type: 'Weekly',
        ));
    _addedCategoryNumber++;
    notifyListeners();
  }

  void saveCategories() async {
    await CategoryService().saveCategories(_categories, _deletedCategoryIds);
    fetchCategories();
    notifyListeners();
  }

  Future getCategoriesWithExpenses(String type) async {
    int year = getYear(DateTime.now());
    int week = getWeekOfYear(DateTime.now());
    int month = getMonth(DateTime.now());

    type == "Weekly"
        ? _weeklyCategoryExpenses = await CategoryService()
            .getCategoriesWithExpenses(_categories, year, week: week)
        : _monthlyCategoryExpenses = await CategoryService()
            .getCategoriesWithExpenses(_categories, year, month: month);
    notifyListeners();
  }

  void editCategory(int index, CategoryData category) {
    _categories[index] = category;
    notifyListeners();
  }

  void addExpense() async {
    fetchTotalExpense();
    await getCategoriesWithExpenses('Weekly');
    await getCategoriesWithExpenses('Monthly');
    notifyListeners();
  }

  Future fetchCategories() async {
    _categories = await CategoryService().getCategories();
    _initialCategories = List.from(_categories);
    notifyListeners();
  }

  Future fetchData() async {
    await fetchCategories();
    await getCategoriesWithExpenses('Weekly');
    await getCategoriesWithExpenses('Monthly');
    notifyListeners();
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
