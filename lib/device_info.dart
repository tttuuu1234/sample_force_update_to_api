import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoProvider = Provider<PackageInfo>((_) {
  throw UnimplementedError();
});

final appNameProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(packageInfoProvider).appName;
});

final packageNameProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(packageInfoProvider).packageName;
});

final currentVersionProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(packageInfoProvider).version;
});

final buildNumberProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(packageInfoProvider).buildNumber;
});
