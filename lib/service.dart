import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'device_info.dart';
import 'repository.dart';

final appVersionServiceProvider = Provider<AppVersionService>((ref) {
  return AppVersionService(ref);
});

class AppVersionService {
  const AppVersionService(this.ref);

  final Ref ref;

  Future<bool> confirm() async {
    try {
      final response = await ref.read(appVersionRepositoryProvider).confirm();
      final latestVersion = response.version;
      return ref.read(isUpdatedNotNeededProvider(latestVersion));
    } catch (e) {
      throw Exception();
    }
  }
}
