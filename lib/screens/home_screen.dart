import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_teknikal_fan/cubit/auth_cubit.dart';
import 'package:test_teknikal_fan/cubit/email_varification_cubit.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/widgets/information_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;

  @override
  void initState() {
    //check if user is email verified periodically
    // BlocProvider.of<AuthCubit>(context).getUser();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        BlocProvider.of<EmailVarificationCubit>(context).checkEmailVerified();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget heading() {
      return Container(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(150),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor,
                    greyColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                          'User Profile',
                          style: txSemiBold.copyWith(
                            color: whiteColor,
                            fontSize: 28,
                          ),
                        ),
                        Spacer(),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: redColor,
                                  content: Text(state.message),
                                ),
                              );
                            } else if (state is AuthInitial) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const CircularProgressIndicator();
                            }
                            return IconButton(
                              onPressed: () {
                                //logout
                                context.read<AuthCubit>().signOut();
                              },
                              icon: Icon(
                                Icons.logout_rounded,
                                color: whiteColor,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //profile picture
                ],
              ),
            ),
            Positioned(
              bottom: -40,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage('assets/icon.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget informationSection() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                runSpacing: 20,
                children: [
                  InformationTileWidget(
                    title: state.user.name,
                    icon: Icons.person_2_outlined,
                    color: primaryColor,
                  ),
                  InformationTileWidget(
                    title: state.user.email,
                    icon: Icons.email_outlined,
                    color: primaryColor,
                  ),
                  BlocBuilder<EmailVarificationCubit, EmailVarificationState>(
                    builder: (context, state) {
                      context
                          .read<EmailVarificationCubit>()
                          .checkEmailVerified();
                      if (state is EmailVerificationSuccess) {
                        return InformationTileWidget(
                          title: 'Email Status\nVerified',
                          icon: Icons.mark_email_read_outlined,
                          color: primaryColor,
                          authStatus: true,
                        );
                      } else if (state is EmailVerificationFailed) {
                        return InformationTileWidget(
                          title: 'Email Status\nNot Verified',
                          icon: Icons.mail_lock_outlined,
                          color: redColor,
                          authStatus: false,
                          onTap: () {
                            context
                                .read<EmailVarificationCubit>()
                                .sendVerificationEmail();
                          },
                        );
                      }
                      return InformationTileWidget(
                        title: 'Email Status',
                        icon: Icons.mail_lock_outlined,
                        color: primaryColor,
                        authStatus: false,
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                runSpacing: 20,
                children: [
                  InformationTileWidget(
                    title: 'Load Data',
                    color: primaryColor,
                    icon: Icons.person_2_outlined,
                  ),
                  InformationTileWidget(
                    title: 'Load Data',
                    color: primaryColor,
                    icon: Icons.email_outlined,
                  ),
                  InformationTileWidget(
                    title: 'Email Verified',
                    color: primaryColor,
                    icon: Icons.attach_email_outlined,
                    authStatus: false,
                  )
                ],
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            heading(),
            SizedBox(
              height: 70,
            ),
            informationSection(),
          ],
        ),
      )),
    );
  }
}
