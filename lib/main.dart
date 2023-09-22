import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sampel_force_update_to_api/device_info.dart';
import 'package:sampel_force_update_to_api/notifier.dart';
import 'package:sampel_force_update_to_api/service.dart';

final navigatorKeyProvider = Provider((_) {
  return GlobalKey<NavigatorState>();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        packageInfoProvider.overrideWithValue(
          await PackageInfo.fromPlatform(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  @override
  void initState() {
    Future(() async {
      await _confirmAppVersion();
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: ref.watch(navigatorKeyProvider),
      home: const HomePage(),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await _confirmAppVersion();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> _confirmAppVersion() async {
    try {
      final isUpdatedNotNeeded =
          await ref.read(appVersionServiceProvider).confirm();
      final isShow = ref.read(appVersionUpdateDialogProvider);
      // ダイアログ表示済みor更新の必要ない場合は、ダイアログを表示させないため
      if (isShow || isUpdatedNotNeeded) {
        return;
      }

      if (!context.mounted) {
        return;
      }

      final currentContext = ref.read(navigatorKeyProvider).currentContext!;
      // バックグラウンド復帰時にダイアログが重なって表示されるのを防ぐため
      ref.read(appVersionUpdateDialogProvider.notifier).show();
      await showAdaptiveDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('アプリのバージョンが更新されました。\nストアから更新をしてください。'),
            actions: [
              TextButton(onPressed: () {}, child: const Text('OK')),
            ],
          );
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
    );
  }
}
