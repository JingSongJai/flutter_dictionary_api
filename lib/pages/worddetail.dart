import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project_dictionary/model/wordinfo.dart';
import 'package:project_dictionary/pages/worddefinition.dart';

class WordDetail extends StatefulWidget {
  const WordDetail({
    super.key,
    required this.word,
    required this.no,
  });

  final WordInfo word;
  final String no;

  @override
  State<WordDetail> createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return widget.word.word != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.no}. ${widget.word.word!}',
                    style: TextStyle(
                      fontFamily: 'JetBrains',
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 5),

                  // Phonetics

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.word.phonetics!
                          .map(
                            (word) => word.audio != null && word.text != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        word.text!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          try {
                                            if (word.audio != null ||
                                                word.audio!.isEmpty) {
                                              await player.setUrl(word.audio!);
                                              player.play();
                                            }
                                          } catch (e) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'Error occured!'),
                                                content: Text(e.toString()),
                                                actions: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Close'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'lib/assets/svg/sound.svg',
                                          colorFilter: ColorFilter.mode(
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            BlendMode.srcIn,
                                          ),
                                          width: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  )
                                : const SizedBox(),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Part of speech

                  Column(
                    children: widget.word.meanings!
                        .map(
                          (meaning) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: Text(
                                    meaning.partOfSpeech!.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'JetBrains',
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),

                              // Definitions

                              const SizedBox(height: 10),
                              Column(
                                children: meaning.definitions!
                                    .map(
                                      (definition) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        width:
                                            MediaQuery.sizeOf(context).width -
                                                40,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 2,
                                                ),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                // child: Text(
                                                //   definition.definition!,
                                                //   style: TextStyle(
                                                //     fontFamily: 'JetBrains',
                                                //     fontSize: 12,
                                                //     color: Theme.of(context)
                                                //         .colorScheme
                                                //         .primary,
                                                //   ),
                                                //   overflow:
                                                //       TextOverflow.visible,
                                                // ),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  children: definition
                                                      .definition!
                                                      .split(' ')
                                                      .map(
                                                        (w) => GestureDetector(
                                                          onTap: () {
                                                            String word = w;
                                                            [';', ',', '.', '?']
                                                                .forEach(
                                                              (value) {
                                                                word = w
                                                                    .replaceAll(
                                                                        value,
                                                                        '');
                                                              },
                                                            );
                                                            print(word);
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        WordDefinition(
                                                                  word: word,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            '$w ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'JetBrains',
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),

                                            // Example

                                            definition.example != null
                                                ? Row(
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: SizedBox(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width -
                                                                  50,
                                                          child: Text(
                                                            'Example: ${definition.example!}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'JetBrains',
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),

                                            // Synonyms

                                            definition.synonyms!.isNotEmpty
                                                ? SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 10,
                                                                vertical: 2,
                                                              ),
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .background
                                                                  .withOpacity(
                                                                      0.5),
                                                              child: Text(
                                                                'Synonyms',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'JetBrains',
                                                                  fontSize: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children:
                                                              definition
                                                                  .synonyms!
                                                                  .map(
                                                                    (syn) =>
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator
                                                                            .pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                WordDefinition(word: syn),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        '$syn ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'JetBrains',
                                                                          fontSize:
                                                                              12,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .primary,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),

                                            // Antonyms

                                            definition.antonyms!.isNotEmpty
                                                ? Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                              vertical: 2,
                                                            ),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .background
                                                                .withOpacity(
                                                                    0.5),
                                                            child: Text(
                                                              'Antonyms',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'JetBrains',
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Wrap(
                                                        direction:
                                                            Axis.horizontal,
                                                        children:
                                                            definition.antonyms!
                                                                .map(
                                                                  (syn) =>
                                                                      GestureDetector(
                                                                    child: Text(
                                                                      '$syn ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'JetBrains',
                                                                        fontSize:
                                                                            12,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .primary,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          )
        : Expanded(
            child: Center(
              child: Text('Word not found!'),
            ),
          );
  }
}
