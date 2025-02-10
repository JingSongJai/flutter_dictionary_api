import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_dictionary/components/worditem.dart';
import 'package:project_dictionary/constant/constantvalue.dart';
import 'package:project_dictionary/pages/worddefinition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          height: 120,
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
                      AppLocalizations.of(context)!.bookmark,
                      style: const TextStyle(
                        fontFamily: 'JetBrains',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    ConstantValue.onChangeMode(context),
                  ],
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: ConstantValue.getBookmark(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Scrollbar(
                    interactive: true,
                    radius: const Radius.circular(5),
                    thickness: 5,
                    child: ListView.separated(
                      itemCount: (snapshot.data ?? []).length,
                      itemBuilder: (context, index) => WordItem(
                        onTap: () {
                          ConstantValue.addHistory(snapshot.data![index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WordDefinition(word: snapshot.data![index]),
                            ),
                          );
                        },
                        word: snapshot.data![index],
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
