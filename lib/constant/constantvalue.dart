import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_dictionary/model/themedata.dart';
import 'package:project_dictionary/theme/lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConstantValue {
  static Widget onChangeMode(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeDataBase>().switchTheme();
      },
      child: Icon(
        Icons.dark_mode,
        color: context.read<ThemeDataBase>().getTheme == lightMode
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
      ),
    );
  }

  static void addBookmark(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> words = [];
    words = prefs.getStringList('bookmark') ?? [];
    words.add(word);
    await prefs.setStringList('bookmark', words);
  }

  static void removeBookmark(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> words = [];
    words = prefs.getStringList('bookmark') ?? [];
    words.remove(word);
    await prefs.setStringList('bookmark', words);
  }

  static Future<bool> isExisted(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var words = prefs.getStringList('bookmark') ?? [];
    return words.contains(word);
  }

  static Future<List<String>> getBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmark') ?? [];
  }

  static void addHistory(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> words = [];
    words = prefs.getStringList('history') ?? [];
    if (!words.contains(word)) {
      words.add(word);
    }
    await prefs.setStringList('history', words);
  }

  static void removeHistory(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> words = [];
    words = prefs.getStringList('history') ?? [];
    words.remove(word);
    await prefs.setStringList('history', words);
  }

  static Future<List<String>> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('history') ?? [];
  }

  static Future<String> getLanguageName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }

  static void saveLanguage(String languageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageName);
  }

  static TextStyle settingText(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: 'JetBrains',
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }

  static void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        content: Text(
          AppLocalizations.of(context)!.message,
          textAlign: TextAlign.center,
          style: settingText(context),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: settingText(context, color: Colors.redAccent),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              if (Platform.isAndroid) {
                exit(0);
              }
            },
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: settingText(context),
            ),
          ),
        ],
      ),
    );
  }
}
