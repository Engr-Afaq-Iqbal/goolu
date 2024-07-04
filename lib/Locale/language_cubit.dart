import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Config/app_config.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void localeSelected(String value) {
    emit(Locale(value));
  }

  getCurrentLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String currLang = sharedPreferences.containsKey("currentLanguageKey")
        ? sharedPreferences.getString("currentLanguageKey")!
        : AppConfig.languageDefault;
    localeSelected(currLang);
  }

  setCurrentLanguage(String langCode, bool save) async {
    if (save) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("currentLanguageKey", langCode);
    }
    localeSelected(langCode);
  }
}
