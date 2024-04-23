import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/splash/presentation/viewmodel/splash_view_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late bool _logoVisible;

  @override
  void initState() {
    super.initState();
    _logoVisible = false;

    // After a delay, show the logo with a fade-in animation
    Timer(Duration(seconds: 1), () {
      setState(() {
        _logoVisible = true;
      });

      // After another delay, navigate to the next screen
      Timer(Duration(seconds: 3), () {
        ref.read(splashViewModelProvider.notifier).init(context);
      });
    });
  }

  //   void initState() {
  //   super.initState();
  //   _logoVisible = false;
  //   Future.delayed(const Duration(seconds: 2), () {
  //     ref.read(splashViewModelProvider.notifier).init(context);
  //   });
  //   setState(() {
  //     _logoVisible = true;
  //   });
  // }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with fade-in animation
            AnimatedOpacity(
              duration: Duration(seconds: 3),
              opacity: _logoVisible ? 1.0 : 0.0,
              child: Image.asset(
                'assets/images/logo.png', // Replace with your logo image path
              ),
            ),
            SizedBox(height: 16), 
            const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}