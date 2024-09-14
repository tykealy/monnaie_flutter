import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:monnaie/models/category_data.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.onDelete,
    required this.onModify,
    required this.category,
  });

  final VoidCallback onDelete;
  final void Function(CategoryData) onModify;
  final CategoryData category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _showEmojiPicker = false;

  late TextEditingController _icon;
  late TextEditingController _categoryName;
  late TextEditingController _categoryAmount;
  late TextEditingController _selectedOption;

  final List<String> categoryOption = ['Weekly', 'Monthly', 'Yearly'];

  @override
  void initState() {
    super.initState();
    _icon = TextEditingController(text: widget.category.icon);
    _categoryName = TextEditingController(text: widget.category.name);
    _selectedOption = TextEditingController(text: widget.category.type);
    _categoryAmount =
        TextEditingController(text: widget.category.budget.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0.3,
          color: const Color(0xFFc7bab8),
        ),
      ),
      child: Material(
        color: const Color(0xFFf3ebea),
        elevation: 3,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          // padding: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Toggle the emoji picker when tapping the input
                        setState(() {
                          _showEmojiPicker = !_showEmojiPicker;
                        });
                      },
                      child: Container(
                        width: 50, // Circular size
                        height: 50, // Circular size
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFebdedc),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.category.icon,
                          style: const TextStyle(fontSize: 24), // Emoji size
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          widget.onModify(CategoryData(
                            id: widget.category.id,
                            icon: _icon.text,
                            name: _categoryName.text,
                            type: _selectedOption.text,
                            budget: double.parse(_categoryAmount.text),
                          ));
                        },
                        controller: _categoryName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        onTapOutside: (event) => FocusScope.of(context)
                            .unfocus(), // Unfocus the text field
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          filled: true, // Enable background color
                          fillColor: Color(0xFFebdedc),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                if (_showEmojiPicker)
                  SizedBox(
                    height: 300,
                    child: EmojiPicker(
                      onEmojiSelected: (Category? category, Emoji emoji) {
                        setState(() {
                          _showEmojiPicker = false;
                        });
                        _icon.text = emoji.emoji;
                        widget.onModify(CategoryData(
                          id: widget.category.id,
                          icon: emoji.emoji,
                          name: _categoryName.text,
                          type: _selectedOption.text,
                          budget: double.parse(_categoryAmount.text),
                        ));
                      },
                      config: const Config(
                        emojiSizeMax: 32.0,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.SMILEYS,
                        bgColor: Color(0xFFf3ebea),
                        indicatorColor: Color(0xFFfdbf1e),
                        iconColor: Colors.grey,
                        iconColorSelected: Color(0xFFfdbf1e),
                        backspaceColor: Colors.red,
                        enableSkinTones: true,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                        recentsLimit: 28,
                        noRecents: Text(
                          'No Recents',
                          style: TextStyle(color: Colors.black26, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Allocated Amount',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          double budgetedValue = 0.0;
                          if (value.isNotEmpty) {
                            try {
                              budgetedValue = double.parse(value);
                            } catch (e) {
                              // Handle the error if needed
                              budgetedValue = 0.0;
                            }
                          }
                          widget.onModify(CategoryData(
                            id: widget.category.id,
                            icon: _icon.text,
                            name: _categoryName.text,
                            type: _selectedOption.text,
                            budget: budgetedValue,
                          ));
                        },
                        controller: _categoryAmount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        onTapOutside: (event) => FocusScope.of(context)
                            .unfocus(), // Unfocus the text field
                        cursorColor: Colors.black,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                          ), //
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          filled: true, // Enable background color
                          fillColor: Color(0xFFebdedc),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15, right: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)), // Border radius
                            borderSide: BorderSide.none, // Remove border
                          ),
                          filled: true, // Enable background color
                          fillColor: Color(0xFFebdedc),
                        ),
                        items: categoryOption.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        value: categoryOption.contains(_selectedOption.text)
                            ? _selectedOption.text
                            : null,
                        onChanged: (value) => setState(() {
                          _selectedOption.text = value!;
                          widget.onModify(CategoryData(
                            id: widget.category.id,
                            icon: _icon.text,
                            name: _categoryName.text,
                            type: value,
                            budget: double.parse(_categoryAmount.text),
                          ));
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      iconSize: 30,
                      onPressed: widget.onDelete,
                      icon: const Icon(Icons.delete_outline),
                      style: ButtonStyle(
                        iconColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red.shade400),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
