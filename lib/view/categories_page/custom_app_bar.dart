import 'package:flutter/material.dart';
import 'package:monnaie/widgets/styled_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
            action: () {
              Navigator.pop(context);
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
