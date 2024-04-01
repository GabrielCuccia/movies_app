import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/config/router/app_router.dart';
import 'package:movies_app/config/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/presentation/providers/theme/mode_provider.dart';

Future<void> main() async {

  await dotenv.load(fileName: ".env");

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDark = ref.watch(isDarkProvider);
    

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      
      theme: AppTheme(isDark: isDark).getTheme(),
    );
  }
}
