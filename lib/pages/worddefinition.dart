import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project_dictionary/constant/constantvalue.dart';
import 'package:project_dictionary/model/wordinfo.dart';
import 'package:project_dictionary/pages/worddetail.dart';

class WordDefinition extends StatefulWidget {
  const WordDefinition({
    super.key,
    required this.word,
  });

  final String word;

  @override
  State<WordDefinition> createState() => _WordDefinitionState();
}

class _WordDefinitionState extends State<WordDefinition> {
  final AudioPlayer player = AudioPlayer();
  late List<WordInfo> list;

  Future<List<WordInfo>> fetchData() async {
    Response response = await get(Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/en/${widget.word}'));
    var jsonBody = jsonDecode(response.body);
    list = (jsonBody as List).map((body) => WordInfo.fromJson(body)).toList();
    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 250,
            color: Theme.of(context).colorScheme.background,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      ConstantValue.onChangeMode(context),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.word,
                    style: const TextStyle(
                      fontFamily: 'JetBrains',
                      fontSize: 34,
                      color: Colors.white,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Lottie.asset(
                  //       'lib/assets/bookmark.json',
                  //       width: 60,
                  //     ),
                  //     Lottie.asset(
                  //       'lib/assets/copy.json',
                  //       width: 60,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                );
              } else if (snapshot.hasError) {
                return Expanded(
                    child: Center(child: Text('Error : ${snapshot.error}')));
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return WordDetail(
                          no: (index + 1).toString(),
                          word: list[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
