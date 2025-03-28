// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(movieName) => "${movieName} added to favourites";

  static String m1(rating) => "${rating} / 10 IMDb";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "croatian": MessageLookupByLibrary.simpleMessage("Croatian"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "favourite_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Favourite movies failed",
    ),
    "favourites": MessageLookupByLibrary.simpleMessage("Favourites"),
    "fetch_app_version_failed": MessageLookupByLibrary.simpleMessage(
      "Fetch app version failed",
    ),
    "fetch_genres_failed": MessageLookupByLibrary.simpleMessage(
      "Fetch genres failed",
    ),
    "fetch_language_failed": MessageLookupByLibrary.simpleMessage(
      "Fetch language failed",
    ),
    "fetch_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Fetch movies failed",
    ),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "load_favourite_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Load favourite movies failed",
    ),
    "movie_added_to_favourites": m0,
    "movie_rating": m1,
    "movies": MessageLookupByLibrary.simpleMessage("Movies"),
    "no_favourite_movies": MessageLookupByLibrary.simpleMessage(
      "🍿 No favourites yet?\n Your top picks will appear here soon! 🎥✨",
    ),
    "permission_denied": MessageLookupByLibrary.simpleMessage(
      "Permission has been denied, please enable it in device settings",
    ),
    "popular": MessageLookupByLibrary.simpleMessage("Popular"),
    "set_language_failed": MessageLookupByLibrary.simpleMessage(
      "Set language failed",
    ),
    "set_theme_failed": MessageLookupByLibrary.simpleMessage(
      "Set theme mode failed",
    ),
    "spanish": MessageLookupByLibrary.simpleMessage("Spanish"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "try_again": MessageLookupByLibrary.simpleMessage("Try again"),
    "unfavourite_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Unfavourite movies failed",
    ),
    "unknown_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Unknown error occurred",
    ),
    "unknown_genre": MessageLookupByLibrary.simpleMessage("Unknown"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
  };
}
