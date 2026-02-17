import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/config/env.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init((options) {
    options.dsn = Env.sentryDsn;
    options.environment = Env.isProduction ? 'production' : 'development';
    options.tracesSampleRate = 0.2;
  });

  runApp(const ProviderScope(child: EstigoApp()));
}

class EstigoApp extends ConsumerWidget {
  const EstigoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Estigo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      routerConfig: router,
    );
  }
}
