// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/presentation/build_context_extensions.dart';
import '../../../common/presentation/spacing.dart';
import '../../domain/notifiers/example_simple_notifier/example_simple_notifier.dart';
import '../../domain/notifiers/example_simple_notifier/example_simple_state.dart';

class ExampleSimplePage extends ConsumerStatefulWidget {
  static const routeName = '/example-simple-page';

  const ExampleSimplePage({super.key});

  @override
  ConsumerState<ExampleSimplePage> createState() => _ExampleSimplePageState();
}

class _ExampleSimplePageState extends ConsumerState<ExampleSimplePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exampleSimpleNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example simple page'),
      ),
      body: ListView(
        children: [
          spacing16,
          Text(
            switch (state) {
              ExampleSimpleStateInitial() => 'Initial',
              ExampleSimpleStateEmpty() => 'Empty',
              ExampleSimpleStateFetching() => 'Fetching',
              ExampleSimpleStateSuccess(data: final string) => string,
              ExampleSimpleStateError(failure: final failure) => failure.title,
            },
            textAlign: TextAlign.center,
            style: context.appTextStyles.regular,
          ),
          spacing16,
          TextButton(
            onPressed: () {
              ref
                  .read(exampleSimpleNotifierProvider.notifier)
                  .getSomeStringSimpleExample();
              ref
                  .read(exampleSimpleNotifierProvider.notifier)
                  .getSomeStringSimpleExample();
            },
            child: Text(
              'Simple state example with debounce',
              style: context.appTextStyles.bold,
            ),
          ),
          spacing16,
          TextButton(
            onPressed: ref
                .read(exampleSimpleNotifierProvider.notifier)
                .getSomeStringSimpleExampleGlobalLoading,
            child: Text(
              'Global loading example',
              style: context.appTextStyles.bold,
            ),
          ),
        ],
      ),
    );
  }
}
