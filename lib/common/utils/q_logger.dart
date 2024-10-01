// ignore_for_file: always_use_package_imports

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import '../../main/app_environment.dart';

class QLogger extends StatelessWidget {
  const QLogger._();

  static void showLogger(BuildContext context) {
    if (!EnvInfo.isProduction || kDebugMode) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => const QLogger._(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ),
            const Expanded(child: LoggyStreamWidget()),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Copy log'),
                    onPressed: () async {
                      final logRecords = _getLastNLogRecords();
                      if (logRecords == null) return;
                      Clipboard.setData(
                        ClipboardData(
                          text: StringBuffer(logRecords).toString(),
                        ),
                      );
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Log copied to clipboard'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static List<String>? getLastNLogLines({int numberOfLines = 2000}) =>
      _getLastNLogRecords(numberOfLines: numberOfLines)
          ?.map((e) => e.message)
          .toList();

  static List<LogRecord>? _getLastNLogRecords({int numberOfLines = 2000}) {
    final StreamPrinter? printer = Loggy.currentPrinter is StreamPrinter
        ? Loggy.currentPrinter as StreamPrinter?
        : null;
    if (printer == null) return null;
    var logRecords = printer.logRecord.value;
    if (logRecords.length > numberOfLines) {
      logRecords = logRecords.sublist(0, numberOfLines);
    }
    return logRecords;
  }
}

class DisabledPrinter extends LoggyPrinter {
  const DisabledPrinter() : super();

  @override
  void onLog(LogRecord record) {}
}
