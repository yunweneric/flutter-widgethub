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
  static const String payUnitUser = String.fromEnvironment('PAY_UNIT_USER');
  static const String payUnitPassword = String.fromEnvironment('PAY_UNIT_PASSWORD');
  static const String payUnitBaseUrl = String.fromEnvironment('PAY_UNIT_BASEURL');
  static const String payUnitApiKey = String.fromEnvironment('PAY_UNIT_APIKEY');
  static const String returnUrl = String.fromEnvironment('RETURN_URL');

  static final AppConfig instance = AppConfig._privateConstructor();

  void init({required AppEnv env}) {
    instance.env = env;
  }
}
