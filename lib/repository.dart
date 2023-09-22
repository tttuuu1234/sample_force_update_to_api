import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sampel_force_update_to_api/model.dart';

final appVersionRepositoryProvider =
    Provider.autoDispose<AppVersionRepository>((ref) {
  return const AppVersionRepository();
});

class AppVersionRepository {
  const AppVersionRepository();

  Future<AppVersionModel> confirm() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return AppVersionModel.fromJson({'version': '1.2.0', 'device': 1});
    } catch (e) {
      throw Exception('エラーが発生しました。');
    }
  }
}
