import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/core/routing/app_route.dart';
import 'package:store_app/core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token_key');

  String startRoute;
  if (token != null && token.isNotEmpty) {
    startRoute = Routes.homeScreen;
  } else {
    startRoute = Routes.loginScreen;
  }
  runApp(MyApp(startRoute: startRoute));
}

class MyApp extends StatelessWidget {
  final String startRoute;

  const MyApp({super.key, required this.startRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: startRoute,
      onGenerateRoute: AppRoute().generateRoute,
      );
  }
}
