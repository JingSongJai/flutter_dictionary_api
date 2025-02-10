import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_dictionary/constant/constantvalue.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({
    super.key,
    required this.word,
    required this.onTap,
  });

  final String word;
  final Function() onTap;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.word),
      onDismissed: (direction) {
        ConstantValue.removeHistory(widget.word);
      },
      child: GestureDetector(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
