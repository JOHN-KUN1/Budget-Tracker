import 'package:budget_tracker/screens/tabs_screen.dart';
import 'package:budget_tracker/services/get_it_service.dart';
import 'package:budget_tracker/services/navigation_service.dart';
import 'package:budget_tracker/view_models/shared_preferences_provider.dart';
import 'package:budget_tracker/view_models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  final prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ref.watch(themeProvider),
      home: const TabsScreen(),
    );
  }
}
