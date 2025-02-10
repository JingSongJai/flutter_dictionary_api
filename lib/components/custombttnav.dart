import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBttNav extends StatefulWidget {
  const CustomBttNav({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  @override
  State<CustomBttNav> createState() => _CustomBttNavState();
}

class _CustomBttNavState extends State<CustomBttNav> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          widget.pageController.jumpToPage(index);
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.background,
      unselectedItemColor: Theme.of(context).colorScheme.primary,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'JetBrains',
        fontSize: 11,
        fontWeight: FontWeight.w300,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'JetBrains',
        fontSize: 11,
        fontWeight: FontWeight.w300,
      ),
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            width: 20,
            'lib/assets/svg/home_nav.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 0
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            width: 20,
            'lib/assets/svg/history_nav.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 1
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          label: AppLocalizations.of(context)!.history,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            width: 20,
            'lib/assets/svg/bookmark_nav.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 2
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          label: AppLocalizations.of(context)!.bookmark,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            width: 20,
            'lib/assets/svg/settings_nav.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 3
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          label: AppLocalizations.of(context)!.settings,
        ),
      ],
    );
  }
}
