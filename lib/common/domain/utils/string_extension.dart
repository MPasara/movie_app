extension StringExtension on String {
  String get lastPart {
    final parts = split('/');
    return parts.isNotEmpty ? parts.last.replaceAll(':', '') : '';
  }

  String removeLeading(String character) => replaceFirst(character, '');

  String get removeLeadingSlash => replaceFirst('/', '');

  String get removeLeadingColon => replaceFirst(':', '');

  String replaceLast(String from, String to) {
    final lastIndex = lastIndexOf(from);
    return lastIndex != -1
        ? replaceRange(lastIndex, lastIndex + from.length, to)
        : this;
  }
}
