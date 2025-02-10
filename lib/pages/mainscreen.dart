import 'package:flutter/material.dart';
import 'package:project_dictionary/components/custombttnav.dart';
import 'package:project_dictionary/pages/bookmarkpage.dart';
import 'package:project_dictionary/pages/historypage.dart';
import 'package:project_dictionary/pages/homepage.dart';
import 'package:project_dictionary/pages/settingspage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();

  List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const BookmarkPage(),
    const SettingsPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages.map((page) => page).toList(),
      ),
      bottomNavigationBar: CustomBttNav(
        pageController: pageController,
      ),
    );
  }
}
