import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_teknikal_fan/cubit/auth_cubit.dart';
import 'package:test_teknikal_fan/screens/home_screen.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/cubit/email_varification_cubit.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    //check if user is email verified periodically
    BlocProvider.of<AuthCubit>(context).getUser();
    Timer.periodic(Duration(seconds: 5), (timer) {
      BlocProvider.of<EmailVarificationCubit>(context).checkEmailVerified();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final emailVerificationCubit = BlocProvider.of<EmailVarificationCubit>(
        context); // Mendapatkan instance dari Cubit

    Widget heading() => Container(
          margin: EdgeInsets.only(
            top: 12,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(bottom: 28),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: softGreyColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    //exit
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: blackColor,
                  ),
                ),
              ),
              Text(
                'Please Check Your Email',
                style: txBold.copyWith(
                  color: blackColor,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We Have Sent you an email containing link verification on your email account',
                style: txMedium.copyWith(
                  color: greyColor,
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              heading(),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<EmailVarificationCubit, EmailVarificationState>(
                listener: (context, state) {
                  if (state is EmailVerificationSuccess) {
                    // Jika email sudah diverifikasi, maka akan kembali ke halaman home
                    Navigator.pushAndRemoveUntil(
                        context,
                        // MaterialPageRoute(builder: (context) => HomeScreen()),
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Email verified!'),
                        backgroundColor: greenColor.withOpacity(0.5),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<EmailVarificationCubit,
                      EmailVarificationState>(
                    builder: (context, state) {
                      if (state is EmailVerificationSent) {
                        return Text(
                          'Email verification sent!',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else if (state is EmailVerificationLoading) {
                        return CircularProgressIndicator(
                          color: primaryColor,
                        );
                      } else if (state is EmailVerificationFailed) {
                        return Column(
                          children: [
                            Text(
                              'Warning : ${state.message}\n',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Not receive email verification?',
                              style: txMedium,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Memulai pengiriman email verifikasi
                                emailVerificationCubit.sendVerificationEmail();
                              },
                              child: Text('Resend Verification Email'),
                            ),
                          ],
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            // Memulai pengiriman email verifikasi
                            emailVerificationCubit.sendVerificationEmail();
                          },
                          child: Text('Resend Verification Email'),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: Text(
                  'I will verification email latter\nGo to Home Screen',
                  style: txMedium.copyWith(
                    color: whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
