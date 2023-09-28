import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_teknikal_fan/cubit/auth_cubit.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/widgets/btn_widget.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        User? user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } else {
          print(user.email);
          context.read<AuthCubit>().checkUser(user.uid);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.asset(
              'assets/img.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Image.asset(
                      'assets/branding.png',
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
