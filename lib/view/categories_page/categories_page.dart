import 'package:flutter/material.dart';
import 'package:monnaie/view/categories_page/categories_page_body.dart';
import 'package:monnaie/view/categories_page/custom_app_bar.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: CategoriesPageBody(),
    );
  }
}
