class Env {
  Env._();

  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://estiqo-production.up.railway.app',
  );

  static const String sentryDsn = String.fromEnvironment(
    'SENTRY_DSN',
    defaultValue:
        'https://4373fbef97bdca7998f2b91d0cf6c6c3@o4510898289377280.ingest.de.sentry.io/4510898360680528',
  );

  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PK',
    defaultValue: '',
  );

  static const bool isProduction = bool.fromEnvironment('PRODUCTION');

  static String get apiBase => '$apiUrl/api';
}
