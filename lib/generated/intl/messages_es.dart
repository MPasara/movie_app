// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(movieName) => "${movieName} agregado a favoritos";

  static String m1(rating) => "${rating} / 10 IMDb";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appearance": MessageLookupByLibrary.simpleMessage("Apariencia"),
        "croatian": MessageLookupByLibrary.simpleMessage("Croata"),
        "dark": MessageLookupByLibrary.simpleMessage("Oscuro"),
        "description": MessageLookupByLibrary.simpleMessage("Descripción"),
        "english": MessageLookupByLibrary.simpleMessage("Inglés"),
        "favourite_movies_failed": MessageLookupByLibrary.simpleMessage(
            "Error al cargar películas favoritas"),
        "favourites": MessageLookupByLibrary.simpleMessage("Favoritos"),
        "fetch_app_version_failed": MessageLookupByLibrary.simpleMessage(
            "Error al recuperar la versión de la aplicación"),
        "fetch_genres_failed":
            MessageLookupByLibrary.simpleMessage("Error al obtener géneros"),
        "fetch_movies_failed":
            MessageLookupByLibrary.simpleMessage("Error al obtener películas"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "language": MessageLookupByLibrary.simpleMessage("Idioma"),
        "light": MessageLookupByLibrary.simpleMessage("Claro"),
        "load_favourite_movies_failed": MessageLookupByLibrary.simpleMessage(
            "Error al cargar películas favoritas"),
        "movie_added_to_favourites": m0,
        "movie_rating": m1,
        "movies": MessageLookupByLibrary.simpleMessage("Películas"),
        "no_favourite_movies": MessageLookupByLibrary.simpleMessage(
            "🍿 ¿No hay favoritos todavía?\n ¡Tus mejores elecciones aparecerán aquí pronto! 🎥✨"),
        "permission_denied": MessageLookupByLibrary.simpleMessage(
            "Permiso denegado, actívelo en la configuración del dispositivo"),
        "popular": MessageLookupByLibrary.simpleMessage("Popular"),
        "spanish": MessageLookupByLibrary.simpleMessage("Espanol"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "try_again": MessageLookupByLibrary.simpleMessage("Inténtalo de nuevo"),
        "unfavourite_movies_failed": MessageLookupByLibrary.simpleMessage(
            "Error al eliminar de favoritos"),
        "unknown_error_occurred": MessageLookupByLibrary.simpleMessage(
            "Se produjo un error desconocido"),
        "unknown_genre": MessageLookupByLibrary.simpleMessage("Desconocido"),
        "version": MessageLookupByLibrary.simpleMessage("Versión")
      };
}
