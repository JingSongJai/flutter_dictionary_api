import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_dictionary/constant/constantvalue.dart';

class WordItem extends StatefulWidget {
  const WordItem({
    super.key,
    required this.word,
    required this.onTap,
  });

  final String word;
  final Function() onTap;

  @override
  State<WordItem> createState() => _WordItemState();
}

class _WordItemState extends State<WordItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController animateController;

  @override
  void initState() {
    super.initState();
    animateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'lib/assets/svg/word.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    width: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.word,
                    style: TextStyle(
                      fontFamily: 'JetBrains',
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  if (!(await ConstantValue.isExisted(widget.word))) {
                    ConstantValue.addBookmark(widget.word);
                  } else {
                    ConstantValue.removeBookmark(widget.word);
                  }
                  setState(() {});
                },
                child: FutureBuilder(
                  future: ConstantValue.isExisted(widget.word),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Icon(
                        !snapshot.data!
                            ? Icons.bookmark_outline
                            : Icons.bookmark,
                        color: Theme.of(context).colorScheme.primary,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
