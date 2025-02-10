import 'package:flutter/material.dart';
import 'package:project_dictionary/constant/constantvalue.dart';
import 'package:project_dictionary/l10n/l10n.dart';
import 'package:project_dictionary/model/themedata.dart';
import 'package:project_dictionary/pages/mainscreen.dart';
import 'package:project_dictionary/pages/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeDataBase().initTheme();
  String languageName = await ConstantValue.getLanguageName();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeDataBase(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: Provider.of<ThemeDataBase>(context).getTheme,
        routes: {
          '/mainscreen': (context) => const MainScreen(),
        },
        supportedLocales: L10n.all,
        locale: Locale(languageName),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    ),
  );
}
