import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  final Map<String, String> _strings;

  AppLocalizations(this.locale, this._strings);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String get appName => _getString('appName');
  String get welcome => _getString('welcome');
  String get loginTitle => _getString('loginTitle');
  String get loginSubtitle => _getString('loginSubtitle');
  String get phoneHint => _getString('phoneHint');
  String get sendOTP => _getString('sendOTP');
  String get verifyOTP => _getString('verifyOTP');
  String get otpSent => _getString('otpSent');
  String get selectRole => _getString('selectRole');
  String get student => _getString('student');
  String get teacher => _getString('teacher');
  String get parent => _getString('parent');
  String get dashboard => _getString('dashboard');
  String get courses => _getString('courses');
  String get myCourses => _getString('myCourses');
  String get continueLearning => _getString('continueLearning');
  String get recommended => _getString('recommended');
  String get seeAll => _getString('seeAll');
  String get loading => _getString('loading');
  String get error => _getString('error');
  String get retry => _getString('retry');
  String get save => _getString('save');
  String get cancel => _getString('cancel');
  String get submit => _getString('submit');
  String get start => _getString('start');
  String get next => _getString('next');
  String get back => _getString('back');
  String get darkMode => _getString('darkMode');
  String get language => _getString('language');
  String get settings => _getString('settings');
  String get logout => _getString('logout');
  String get enrollNow => _getString('enrollNow');
  String get free => _getString('free');
  String get score => _getString('score');
  String get totalMarks => _getString('totalMarks');
  String get correct => _getString('correct');
  String get wrong => _getString('wrong');
  String get timeTaken => _getString('timeTaken');
  String get congratulations => _getString('congratulations');
  String get tryAgain => _getString('tryAgain');
  String get askDoubt => _getString('askDoubt');
  String get typeMessage => _getString('typeMessage');
  String get myProgress => _getString('myProgress');
  String get streak => _getString('streak');
  String get days => _getString('days');
  String get hours => _getString('hours');
  String get minutes => _getString('minutes');
  String get lessons => _getString('lessons');

  String _getString(String key) {
    return _strings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final jsonString = await rootBundle.loadString(
      'assets/translations/${locale.languageCode}.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final strings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return AppLocalizations(locale, strings);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
