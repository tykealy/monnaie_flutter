import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:monnaie/view/categories_page/category_card.dart';
import 'package:monnaie/models/category_data.dart';

typedef CategoriesChangedCallback = void Function(
    List<CategoryData> categories);
typedef DeletedCategoryCallback = void Function(
    List<String> deletedCategoryIds);

class CategoriesPageBody extends StatefulWidget {
  const CategoriesPageBody({
    super.key,
    required this.deletedCategoryIds,
    required this.categories,
    required this.onCategoriesChanged,
    required this.onDeletedCategoryIdsChanged,
  });
  final List<CategoryData> categories;
  final List<String> deletedCategoryIds;
  final CategoriesChangedCallback onCategoriesChanged;
  final DeletedCategoryCallback onDeletedCategoryIdsChanged;

  @override
  State<CategoriesPageBody> createState() => _CategoriesPageBodyState();
}

class _CategoriesPageBodyState extends State<CategoriesPageBody> {
  late List<CategoryData> categories;
  late List<String> deletedCategoryIds;

  @override
  void initState() {
    super.initState();
    categories = widget.categories;
    deletedCategoryIds = widget.deletedCategoryIds;
  }

  void addCategory() {
    setState(() {
      categories.insert(
          0,
          CategoryData(
            icon: '🍔',
            name: 'New Category',
            budget: 50,
            type: 'Weekly',
          ));
    });
  }

  void deleteCategory(int index) {
    setState(() {
      deletedCategoryIds.add(categories[index].id);
      categories.removeAt(index);
    });
  }

  void editCategory(int index, CategoryData category) {
    setState(() {
      categories[index] = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(4),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(children: [
          AddCategoryWidget(
            onAdd: addCategory,
          ),
          ...(categories).asMap().entries.map((entry) {
            int index = entry.key;
            CategoryData category = entry.value;
            return CategoryCard(
              key: ValueKey(category.id),
              category: category,
              onDelete: () => deleteCategory(index),
              onModify: (newCategory) => editCategory(index, newCategory),
            );
          }),
        ]),
      ),
    );
  }
}

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({
    super.key,
    required this.onAdd,
  });

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onAdd();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: const DashedBorder.fromBorderSide(
              dashLength: 7,
              side: BorderSide(
                  color: Color.fromRGBO(117, 117, 117, 1), width: 1)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Add Category',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(117, 117, 117, 1)),
        ),
      ),
    );
  }
}
