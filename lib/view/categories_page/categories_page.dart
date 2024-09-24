import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monnaie/models/category_data.dart';
import 'package:monnaie/service/category_service.dart';
import 'package:monnaie/view/categories_page/categories_page_body.dart';
import 'package:monnaie/view/categories_page/custom_app_bar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategoryData> _categories = [];
  List<String> _deletedCategoryIds = [];
  List<CategoryData> _initialCategories = [];
  List<String> _initialDeletedCategoryIds = [];
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _saveCategories() async {
    await CategoryService().saveCategories(_categories, _deletedCategoryIds);
  }

  void _handleCategoriesChanged(List<CategoryData> newCategories) {
    setState(() {
      _categories = newCategories;
    });
  }

  void _handleDeletedCategoryIdsChanged(List<String> newDeletedCategoryIds) {
    setState(() {
      _deletedCategoryIds = newDeletedCategoryIds;
    });
  }

  bool hasChanges() {
    _categories.removeWhere((category) => category.name.isEmpty);
    _deletedCategoryIds.removeWhere((id) => id.isEmpty);
    return !const Equality().equals(_categories, _initialCategories) ||
        !const Equality()
            .equals(_deletedCategoryIds, _initialDeletedCategoryIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSave: _saveCategories,
        hasChanges: hasChanges,
      ),
      body: FutureBuilder(
        future: CategoryService().getCategories(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CategoryData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _categories = snapshot.data!;
            _initialCategories = List.from(_categories);
            _initialDeletedCategoryIds = List.from(_deletedCategoryIds);
            return CategoriesPageBody(
              deletedCategoryIds: _deletedCategoryIds,
              categories: _categories,
              onCategoriesChanged: _handleCategoriesChanged,
              onDeletedCategoryIdsChanged: _handleDeletedCategoryIdsChanged,
            );
          }
        },
      ),
    );
  }
}
