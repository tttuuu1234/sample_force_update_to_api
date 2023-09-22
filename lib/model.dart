class AppVersionModel {
  const AppVersionModel._({required this.version, required this.device});

  final String version;
  final int device;

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel._(
      version: json['version'],
      device: json['device'],
    );
  }
}
