import 'package:go_router/go_router.dart';

extension GoRouterStateExtension on GoRouterState {
  T? _getParameterByName<T>({
    required String name,
    required Map<String, String> parameters,
    T? Function(String value)? parser,
  }) {
    assert(T != dynamic, 'Method must have generic type provided.');
    if (!parameters.containsKey(name)) return null;
    final value = parameters[name]!;
    return parser != null
        ? parser(value)
        : switch (T) {
            const (int) => int.tryParse(value) as T?,
            const (String) => value as T?,
            _ => throw UnsupportedError(
                'No parser given and given type is not supported',
              ),
          };
  }

  T? getPathParameterByName<T>({
    required String name,
    T? Function(String value)? parser,
  }) =>
      _getParameterByName(
        name: name,
        parameters: pathParameters,
        parser: parser,
      );

  T? getQueryParameterByName<T>({
    required String name,
    T? Function(String value)? parser,
  }) =>
      _getParameterByName(
        name: name,
        parameters: uri.queryParameters,
        parser: parser,
      );

  String? redirectIfPathParameterValid<T>({
    required String pathParameterName,
    required String redirectTo,
    T? Function(String value)? parser,
  }) =>
      getPathParameterByName<T>(name: pathParameterName, parser: parser) != null
          ? null
          : redirectTo;
}
