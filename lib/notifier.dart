import 'package:flutter_riverpod/flutter_riverpod.dart';

final appVersionUpdateDialogProvider =
    NotifierProvider<AppVersionUpdateDialogNotifier, bool>(
        AppVersionUpdateDialogNotifier.new);

class AppVersionUpdateDialogNotifier extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  void show() {
    state = true;
  }
}
