// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hr locale. All the
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
  String get localeName => 'hr';

  static String m0(movieName) => "${movieName} dodano u favorite";

  static String m1(rating) => "${rating} / 10 IMDb";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appearance": MessageLookupByLibrary.simpleMessage("Izgled"),
    "croatian": MessageLookupByLibrary.simpleMessage("Hrvatski"),
    "dark": MessageLookupByLibrary.simpleMessage("Tamno"),
    "description": MessageLookupByLibrary.simpleMessage("Opis"),
    "english": MessageLookupByLibrary.simpleMessage("Engleski"),
    "favourite_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Filmovi omiljeni nisu uspjeli",
    ),
    "favourites": MessageLookupByLibrary.simpleMessage("Favoriti"),
    "fetch_app_version_failed": MessageLookupByLibrary.simpleMessage(
      "Dohvaćanje verzije aplikacije nije uspjelo",
    ),
    "fetch_genres_failed": MessageLookupByLibrary.simpleMessage(
      "Preuzimanje žanrova nije uspjelo",
    ),
    "fetch_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Preuzimanje filmova nije uspjelo",
    ),
    "general": MessageLookupByLibrary.simpleMessage("Općenito"),
    "language": MessageLookupByLibrary.simpleMessage("Jezik"),
    "light": MessageLookupByLibrary.simpleMessage("Svijetlo"),
    "load_favourite_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Učitavanje favorita nije uspjelo",
    ),
    "movie_added_to_favourites": m0,
    "movie_rating": m1,
    "movies": MessageLookupByLibrary.simpleMessage("Filmovi"),
    "no_favourite_movies": MessageLookupByLibrary.simpleMessage(
      "🍿 Još nema favorita?\n Vaši najbolji odabiri uskoro će se pojaviti ovdje! 🎥✨",
    ),
    "permission_denied": MessageLookupByLibrary.simpleMessage(
      "Dopuštenje je odbijeno, omogućite ga u postavkama uređaja",
    ),
    "popular": MessageLookupByLibrary.simpleMessage("Popularno"),
    "spanish": MessageLookupByLibrary.simpleMessage("Španjolski"),
    "system": MessageLookupByLibrary.simpleMessage("Sustav"),
    "try_again": MessageLookupByLibrary.simpleMessage("Pokušaj ponovno"),
    "unfavourite_movies_failed": MessageLookupByLibrary.simpleMessage(
      "Uklanjanje filmova iz favorita nije uspjelo",
    ),
    "unknown_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Došlo je do nepoznate pogreške",
    ),
    "unknown_genre": MessageLookupByLibrary.simpleMessage("Nepoznato"),
    "version": MessageLookupByLibrary.simpleMessage("Verzija"),
  };
}
