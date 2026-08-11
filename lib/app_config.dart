enum AppEnvironment { dev, prod }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.apiBaseUrl,
  });

  final AppEnvironment environment;
  final String appName;
  final String apiBaseUrl;

  bool get isProduction => environment == AppEnvironment.prod;

  factory AppConfig.fromEnvironment() {
    const appEnv = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    final environment =
        appEnv.toLowerCase() == 'prod' ? AppEnvironment.prod : AppEnvironment.dev;

    return AppConfig(
      environment: environment,
      appName: const String.fromEnvironment(
        'APP_NAME',
        defaultValue: 'Flutter Calculator',
      ),
      apiBaseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://dev.example.com',
      ),
    );
  }
}