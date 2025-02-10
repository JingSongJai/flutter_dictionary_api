import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_dictionary/components/worditem.dart';
import 'package:project_dictionary/constant/constantvalue.dart';
import 'package:project_dictionary/pages/worddefinition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> english_word = [];
  List<String> filter = [];
  final TextEditingController _textController = TextEditingController();

  void filterWord() {
    filter = english_word
        .where((value) =>
            value.toLowerCase().contains(_textController.text.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    english_word = List.from(Set.from(all))
      ..sort(
        (w1, w2) => w1.toLowerCase().compareTo(
              w2.toLowerCase(),
            ),
      );
  }

  @override
  Widget build(BuildContext context) {
    filterWord();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          height: 200,
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/svg/logo_appbar.svg',
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 35,
                    ),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: const TextStyle(
                        fontFamily: 'JetBrains',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    ConstantValue.onChangeMode(context),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 50,
                    color: Colors.white,
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(
                        fontFamily: 'JetBrains',
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        hintText: AppLocalizations.of(context)!.search,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Scrollbar(
              interactive: true,
              radius: const Radius.circular(5),
              thickness: 5,
              child: ListView.separated(
                itemCount: filter.length,
                itemBuilder: (context, index) => WordItem(
                  onTap: () {
                    ConstantValue.addHistory(filter[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WordDefinition(word: filter[index]),
                      ),
                    );
                  },
                  word: filter[index],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
