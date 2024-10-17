import 'package:flutter/material.dart';

class FormValidators {
  String removeWrongSymbols(String curString) {
    String regex = r'[^a-zA-Zа-яА-Я]+';
    removeWrongLetters(curString);
    return curString.replaceAll(RegExp(regex, unicode: true), '');
  }

  String removeWrongLetters(String curString) {
    String regex = r'[^!,".-]+';
    return curString.replaceAll(RegExp(regex, unicode: true), '');
  }

}
