import 'package:flutter/material.dart';
import 'package:project_dictionary/constant/constantvalue.dart';

class SettingItem extends StatefulWidget {
  const SettingItem({
    super.key,
    required this.onTap,
    required this.iconLeading,
    required this.title,
    required this.showLeadingIcon,
  });

  final Function() onTap;
  final IconData iconLeading;
  final String title;
  final bool showLeadingIcon;

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: Visibility(
        visible: widget.showLeadingIcon,
        child: Icon(
          widget.iconLeading,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        widget.title,
        style: ConstantValue.settingText(context),
      ),
    );
  }
}
