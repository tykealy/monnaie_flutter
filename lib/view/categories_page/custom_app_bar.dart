import 'package:flutter/material.dart';
import 'package:monnaie/provider/category_expense_provider.dart';
import 'package:monnaie/widgets/styled_button.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<bool?> showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFf3ebea),
          title: const Text('Confirm Save'),
          content: const Text('Are you sure you want to save?'),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            StyledButton(
              icon: null,
              width: 90,
              label: 'Cancel',
              action: () {
                Navigator.of(context).pop(false);
              },
            ),
            StyledButton(
              width: 90,
              label: 'Save',
              action: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0, // Removes default AppBar title spacing
      title: const Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Aligns everything to the start
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0), // Optional, tweak as needed
            child: Text('Add Category'),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 24),
          child: StyledButton(
            action: () async {
              if (Provider.of<CategoryExpenseProvider>(context, listen: false)
                  .hasChanges()) {
                bool? confirmed = await showConfirmationDialog(context);

                if (confirmed == true && context.mounted) {
                  Provider.of<CategoryExpenseProvider>(context, listen: false)
                      .saveCategories();
                } else if (confirmed == false && context.mounted) {
                  Provider.of<CategoryExpenseProvider>(context, listen: false)
                      .removeAddedCategory();
                }
              }

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check),
            width: 35,
            height: 35,
          ),
        ),
      ],
      automaticallyImplyLeading:
          false, // Completely removes the default back button space
      forceMaterialTransparency: true,
      backgroundColor: const Color(0xFFebdedc),
    );
  }
}
