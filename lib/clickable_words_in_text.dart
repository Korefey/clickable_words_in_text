library clickable_words_in_text;

import 'package:clickable_words_in_text/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ClickableWordsInText extends StatelessWidget {
  const ClickableWordsInText({
    super.key,
    this.spacing = 4,
    this.runSpacing = 4,
    required this.arrContent,
    this.highlightedWords,
    this.onTap,
    this.colorOfWord = Colors.lime,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.screenWidth = 300,
  });

  final double spacing;
  final double runSpacing;
  final List<String> arrContent;
  final List<String>? highlightedWords;
  final void Function(String content, String? selectedWord)? onTap;
  final Color colorOfWord;
  final TextStyle? textStyle;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: arrContent.map(
        (content) {
          final isNewString = content.contains('\n');
          final selectedWord = getWordColor(content);
          // if (selectedWord != null) {
          //   Future.delayed(const Duration(milliseconds: 1), () async {
          //     ref.watch(readingProvider.notifier).addSelectedWord(selectedWord);
          //   });
          // }
          return SizedBox(
            // width: isNewString ? screenWidth : null,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: isNewString ? null : () => onTap!(content, selectedWord),
              child: isNewString
                  ? const SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        color: selectedWord != null ? colorOfWord : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        content,
                        style: textStyle,
                      ),
                    ),
            ),
          );
        },
      ).toList(),
    );
  }

  String? getWordColor(content) {
    if (highlightedWords == null) return null;
    final tempContent = FormValidators().removeWrongSymbols(content).toLowerCase().trim();
    final isSearched = highlightedWords!.firstWhereOrNull((e) {
      return FormValidators().removeWrongSymbols(e).toLowerCase().trim() == tempContent;
    });
    return isSearched;
  }
}
