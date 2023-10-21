import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? frText = '',
  }) =>
      [enText, frText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Home
  {
    '98fyn02b': {
      'en': 'Let\'s learn',
      'fr': '',
    },
    'yztkv029': {
      'en': 'Boring? ',
      'fr': '',
    },
    'nl3fkxr3': {
      'en': 'Log out',
      'fr': '',
    },
    'uu59ro04': {
      'en': 'Latest Lesson',
      'fr': '',
    },
    'n4a9esgd': {
      'en': 'Keep it up!',
      'fr': '',
    },
    'kfoadiux': {
      'en': 'You just have 5 more \nwords in \"Letter A\"',
      'fr': '',
    },
    'hb97b4bc': {
      'en': 'Continue',
      'fr': '',
    },
    'z51w6dxa': {
      'en': '75%',
      'fr': '',
    },
    'qg1wq1ap': {
      'en': 'All lessons\' progress',
      'fr': '',
    },
    'fkt1vi1f': {
      'en': 'Learn by categories',
      'fr': '',
    },
    'st5n0q01': {
      'en': 'Learn by alphabets',
      'fr': '',
    },
    'klr88qtk': {
      'en': 'Home',
      'fr': '',
    },
  },
  // DictionaryAlphabet
  {
    '9pstk7lk': {
      'en': 'Search vocabulary ...',
      'fr': '',
    },
    '6a40doml': {
      'en': 'Option 1',
      'fr': '',
    },
    'v3bdgwrh': {
      'en': 'Search',
      'fr': '',
    },
    'ycmzqoks': {
      'en': 'Dictionary',
      'fr': '',
    },
    'ptzsv032': {
      'en': 'Dictionary',
      'fr': '',
    },
  },
  // FlashCardView
  {
    '1e0n37qi': {
      'en': 'NEW WORD',
      'fr': '',
    },
    'p45dblon': {
      'en': 'REVIEWING',
      'fr': '',
    },
    'tycf4f3f': {
      'en': 'Click to reveal meaning',
      'fr': '',
    },
    'a79dxdg5': {
      'en': 'I didn\'t know this word',
      'fr': '',
    },
    'pv63az42': {
      'en': 'I know this word',
      'fr': '',
    },
    'je4v2yy1': {
      'en': 'Home',
      'fr': '',
    },
  },
  // Onboarding
  {
    'n41q990b': {
      'en': 'VietLingo',
      'fr': '',
    },
    'z88ja78x': {
      'en': 'Are you ready to learn languages easily in the funniest way?',
      'fr': '',
    },
    '484kwky4': {
      'en': 'Log In',
      'fr': '',
    },
    'ze2u089r': {
      'en': 'Sign Up',
      'fr': '',
    },
    'hotfxbdd': {
      'en': 'Home',
      'fr': '',
    },
  },
  // ReadingList
  {
    'omig7ic3': {
      'en': 'Category',
      'fr': '',
    },
    'q2j1l2hb': {
      'en': 'Current Progress',
      'fr': '',
    },
    '9l7gauom': {
      'en': 'You completed',
      'fr': '',
    },
    'ggbhpgr5': {
      'en': 'All categories',
      'fr': '',
    },
    '9klnzqzn': {
      'en': 'Alphabet',
      'fr': '',
    },
    'z6eyuvqk': {
      'en': 'Search vocabulary ...',
      'fr': '',
    },
    'bskl0gb8': {
      'en': 'Search',
      'fr': '',
    },
    'ya7tj3ng': {
      'en': 'You completed',
      'fr': '',
    },
    'dt8oazwr': {
      'en': 'You completed',
      'fr': '',
    },
    '9c4ryp32': {
      'en': 'Reading',
      'fr': '',
    },
    'paqen72h': {
      'en': 'Reading',
      'fr': '',
    },
  },
  // AllCategories
  {
    'wu2gs0dn': {
      'en': 'Page Title',
      'fr': '',
    },
    'pezlv5tw': {
      'en': 'Categories',
      'fr': '',
    },
  },
  // TestFlashCardViewCopy
  {
    'uwmv331p': {
      'en': 'Home',
      'fr': '',
    },
  },
  // SignUp
  {
    'lsmpsbfb': {
      'en': 'Let\'s get started by filling out the form below.',
      'fr': '',
    },
    'ap5itbst': {
      'en': 'Your Name',
      'fr': '',
    },
    'o0abbbwf': {
      'en': 'Email',
      'fr': '',
    },
    'ezslcu1p': {
      'en': 'Password',
      'fr': '',
    },
    '82oj4yz6': {
      'en': 'Confirm password',
      'fr': '',
    },
    '6sz5s8x4': {
      'en': 'Get Started',
      'fr': '',
    },
    'spyu16hu': {
      'en': 'Create your account',
      'fr': '',
    },
  },
  // Login
  {
    '5fn6u6hq': {
      'en': 'Welcome Back',
      'fr': '',
    },
    'qb2s60bv': {
      'en': 'Email',
      'fr': '',
    },
    'jbw60df5': {
      'en': 'Password',
      'fr': '',
    },
    '4ern9syq': {
      'en': 'Sign In',
      'fr': '',
    },
    'i9irwgrf': {
      'en': 'Sign In',
      'fr': '',
    },
    '9ag9riag': {
      'en': 'Home',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    '1ocq9mjq': {
      'en': 'Sign Up',
      'fr': '',
    },
    'd8ms387j': {
      'en': 'Allow us to record audio',
      'fr': '',
    },
    '76p9ikae': {
      'en': '',
      'fr': '',
    },
    'jprti2x0': {
      'en': '',
      'fr': '',
    },
    'nmpdynci': {
      'en': '',
      'fr': '',
    },
    'szpkaf2n': {
      'en': '',
      'fr': '',
    },
    '8byhl8l8': {
      'en': '',
      'fr': '',
    },
    'eavej9x1': {
      'en': '',
      'fr': '',
    },
    '0wtqdx4x': {
      'en': '',
      'fr': '',
    },
    'hvto5tyr': {
      'en': '',
      'fr': '',
    },
    'jnj81utb': {
      'en': '',
      'fr': '',
    },
    'zg8lx7fh': {
      'en': '',
      'fr': '',
    },
    'u2iys0n7': {
      'en': '',
      'fr': '',
    },
    'fxdjl3lh': {
      'en': '',
      'fr': '',
    },
    '276vwmaa': {
      'en': '',
      'fr': '',
    },
    'coko7haq': {
      'en': '',
      'fr': '',
    },
    'acem5ddx': {
      'en': '',
      'fr': '',
    },
    '0l6z6ilt': {
      'en': '',
      'fr': '',
    },
    'brepcwes': {
      'en': '',
      'fr': '',
    },
    'bcoe05qm': {
      'en': '',
      'fr': '',
    },
    '7q76ikls': {
      'en': '',
      'fr': '',
    },
    '48q6qhdl': {
      'en': '',
      'fr': '',
    },
    'u25r9rs2': {
      'en': '',
      'fr': '',
    },
    'tu6hculk': {
      'en': '',
      'fr': '',
    },
    '3jtlyjup': {
      'en': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
