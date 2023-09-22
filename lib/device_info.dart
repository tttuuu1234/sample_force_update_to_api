import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoProvider = Provider<PackageInfo>((_) {
  throw UnimplementedError();
});

final currentVersionProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(packageInfoProvider).version;
});

/// アプリバージョンの更新の必要はないかの確認
final isUpdatedNotNeededProvider =
    Provider.family<bool, String>((ref, latestVersion) {
  final currentVersion = ref.read(currentVersionProvider);
  final splitedCurrentVersion = currentVersion.split('.');
  final splitedLatestVersion = latestVersion.split('.');
  assert(splitedLatestVersion.length == 3, '最新のバージョンが「.」区切りで3桁でない');
  log(splitedCurrentVersion.toString());
  log(splitedLatestVersion.toString());
  // patchバージョンは一致していても不一致でもバージョンの更新は不要なため削除
  splitedCurrentVersion.removeLast();
  splitedLatestVersion.removeLast();
  if (listEquals(splitedCurrentVersion, splitedLatestVersion)) {
    return true;
  }

  return false;
});
