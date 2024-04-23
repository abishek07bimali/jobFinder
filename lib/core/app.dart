import 'package:flutter/material.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/themedata.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoutes(),
      theme: getApplicationTheme(),
    );
  }
}
