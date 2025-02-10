import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_dictionary/components/settingitem.dart';
import 'package:project_dictionary/constant/constantvalue.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      AppLocalizations.of(context)!.settings,
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
        ExpansionTile(
          leading: Icon(
            Icons.language,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            AppLocalizations.of(context)!.language,
            style: ConstantValue.settingText(context),
          ),
          shape: const RoundedRectangleBorder(),
          expansionAnimationStyle: AnimationStyle(
            duration: const Duration(milliseconds: 10),
          ),
          children: [
            SettingItem(
              showLeadingIcon: false,
              onTap: () {
                ConstantValue.saveLanguage('en');
                ConstantValue.showConfirmDialog(context);
              },
              iconLeading: Icons.settings,
              title: AppLocalizations.of(context)!.english,
            ),
            SettingItem(
              showLeadingIcon: false,
              onTap: () {
                ConstantValue.saveLanguage('km');
                ConstantValue.showConfirmDialog(context);
              },
              iconLeading: Icons.settings,
              title: AppLocalizations.of(context)!.khmer,
            ),
          ],
        ),
        SettingItem(
          iconLeading: Icons.info,
          showLeadingIcon: true,
          onTap: () {},
          title: AppLocalizations.of(context)!.about,
        ),
      ],
    );
  }
}
