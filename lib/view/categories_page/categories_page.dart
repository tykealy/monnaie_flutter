import 'package:flutter/material.dart';
import 'package:monnaie/provider/category_expense_provider.dart';
import 'package:monnaie/view/categories_page/categories_page_body.dart';
import 'package:monnaie/view/categories_page/custom_app_bar.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body:
            Consumer<CategoryExpenseProvider>(builder: (context, value, child) {
          return const CategoriesPageBody();
        }));
  }
}
