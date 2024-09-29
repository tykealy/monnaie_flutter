import 'package:flutter/material.dart';
import 'package:monnaie/view/categories_page/categories_page.dart';
import 'package:monnaie/widgets/styled_button.dart';
import 'package:provider/provider.dart';
import '../provider/category_expense_provider.dart';

class SpentCard extends StatefulWidget {
  const SpentCard({super.key});
  @override
  State<SpentCard> createState() => _SpentCardState();
}

class _SpentCardState extends State<SpentCard> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryExpenseProvider>(context, listen: false)
        .fetchTotalExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFebdedc),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFc7bab8),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 12),
                    child: Consumer<CategoryExpenseProvider>(
                      builder: (context, value, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Spent",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            value.totalSpent,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: StyledButton(
                                    label: "Budget",
                                    action: () {},
                                    width: 145,
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: StyledButton(
                                  label: "Category",
                                  action: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => const PopScope(
                                          child: CategoriesPage(),
                                        ),
                                      ),
                                    );
                                  },
                                  width: 145,
                                  icon: const Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
