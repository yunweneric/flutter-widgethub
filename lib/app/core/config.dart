enum AppEnv {
  DEV('dev'),
  PROD('dev'),
  STAGING('staging');

  const AppEnv(this.value);
  final String value;
}

class AppConfig {
  factory AppConfig() => instance;

  AppConfig._privateConstructor();
  late AppEnv env;

  static final AppConfig instance = AppConfig._privateConstructor();

  void init({required AppEnv env}) {
    instance.env = env;
  }
}
