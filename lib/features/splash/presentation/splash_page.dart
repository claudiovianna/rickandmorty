import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';
import 'package:universo_rick_v2/core/design_system/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Modular.to.navigate('/characters');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Rick and Morty', style: AppTextStyles.heading1),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/rick_morty_v2_editado.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            // SizedBox(
            //   height: 30,
            //   width: 30,
            //   child: CircularProgressIndicator(),
            // ),
            SizedBox(
              width: 276,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.background,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
