// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unknown error occurred`
  String get unknown_error_occurred {
    return Intl.message(
      'Unknown error occurred',
      name: 'unknown_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Permission has been denied, please enable it in device settings`
  String get permission_denied {
    return Intl.message(
      'Permission has been denied, please enable it in device settings',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get movies {
    return Intl.message(
      'Movies',
      name: 'movies',
      desc: '',
      args: [],
    );
  }

  /// `{rating} / 10 IMDb`
  String movie_rating(Object rating) {
    return Intl.message(
      '$rating / 10 IMDb',
      name: 'movie_rating',
      desc: '',
      args: [rating],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Fetch genres failed`
  String get fetch_genres_failed {
    return Intl.message(
      'Fetch genres failed',
      name: 'fetch_genres_failed',
      desc: '',
      args: [],
    );
  }

  /// `Fetch movies failed`
  String get fetch_movies_failed {
    return Intl.message(
      'Fetch movies failed',
      name: 'fetch_movies_failed',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown_genre {
    return Intl.message(
      'Unknown',
      name: 'unknown_genre',
      desc: '',
      args: [],
    );
  }

  /// `🍿 No favourites yet?\n Your top picks will appear here soon! 🎥✨`
  String get no_favourite_movies {
    return Intl.message(
      '🍿 No favourites yet?\n Your top picks will appear here soon! 🎥✨',
      name: 'no_favourite_movies',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `{movieName} added to favourites`
  String movie_added_to_favourites(Object movieName) {
    return Intl.message(
      '$movieName added to favourites',
      name: 'movie_added_to_favourites',
      desc: '',
      args: [movieName],
    );
  }

  /// `Favourite movies failed`
  String get favourite_movies_failed {
    return Intl.message(
      'Favourite movies failed',
      name: 'favourite_movies_failed',
      desc: '',
      args: [],
    );
  }

  /// `Unfavourite movies failed`
  String get unfavourite_movies_failed {
    return Intl.message(
      'Unfavourite movies failed',
      name: 'unfavourite_movies_failed',
      desc: '',
      args: [],
    );
  }

  /// `Load favourite movies failed`
  String get load_favourite_movies_failed {
    return Intl.message(
      'Load favourite movies failed',
      name: 'load_favourite_movies_failed',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Croatian`
  String get croatian {
    return Intl.message(
      'Croatian',
      name: 'croatian',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Fetch app version failed`
  String get fetch_app_version_failed {
    return Intl.message(
      'Fetch app version failed',
      name: 'fetch_app_version_failed',
      desc: '',
      args: [],
    );
  }

  /// `Fetch language failed`
  String get fetch_language_failed {
    return Intl.message(
      'Fetch language failed',
      name: 'fetch_language_failed',
      desc: '',
      args: [],
    );
  }

  /// `Set language failed`
  String get set_language_failed {
    return Intl.message(
      'Set language failed',
      name: 'set_language_failed',
      desc: '',
      args: [],
    );
  }

  /// `Set theme mode failed`
  String get set_theme_failed {
    return Intl.message(
      'Set theme mode failed',
      name: 'set_theme_failed',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'hr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
