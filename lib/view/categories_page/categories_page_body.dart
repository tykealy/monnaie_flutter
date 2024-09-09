import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class CategoriesPageBody extends StatefulWidget {
  const CategoriesPageBody({super.key});

  @override
  State<CategoriesPageBody> createState() => _CategoriesPageBodyState();
}

class _CategoriesPageBodyState extends State<CategoriesPageBody> {
  final TextEditingController _controller = TextEditingController();
  bool _showEmojiPicker = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const AddCategoryWidget(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFebdedc),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFc7bab8),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          // Toggle the emoji picker when tapping the input
                          setState(() {
                            _showEmojiPicker = !_showEmojiPicker;
                          });
                        },
                        child: Container(
                          width: 60, // Circular size
                          height: 60, // Circular size
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.circular(30), // Circular shape
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _controller.text.isEmpty
                                ? '😊'
                                : _controller.text, // Display emoji or hint
                            style: const TextStyle(fontSize: 24), // Emoji size
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showEmojiPicker)
                  SizedBox(
                    height: 300,
                    child: EmojiPicker(
                      onEmojiSelected: (Category? category, Emoji emoji) {
                        _controller.text = emoji.emoji;
                      },
                      config: const Config(
                        columns: 7,
                        emojiSizeMax: 32.0,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.SMILEYS,
                        bgColor: Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
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
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
          borderRadius: BorderRadius.circular(6),
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
