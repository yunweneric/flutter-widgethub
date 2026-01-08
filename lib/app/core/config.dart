/// Application environment configuration.
///
/// Defines the different environments the application can run in.
/// Each environment has an associated string value used for configuration.
enum AppEnv {
  /// Development environment.
  DEV('dev'),

  /// Production environment.
  PROD('dev'),

  /// Staging environment.
  STAGING('staging');

  /// Creates an [AppEnv] with the given [value].
  const AppEnv(this.value);

  /// The string value associated with this environment.
  final String value;
}

// class AppConfig {
//   factory AppConfig() => instance;

//   AppConfig._privateConstructor();
//   late AppEnv env;

//   static final AppConfig instance = AppConfig._privateConstructor();

//   void init({required AppEnv env}) {
//     instance.env = env;
//   }
// }
