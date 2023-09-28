import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_teknikal_fan/cubit/auth_cubit.dart';
import 'package:test_teknikal_fan/cubit/email_varification_cubit.dart';
import 'package:test_teknikal_fan/screens/home_screen.dart';
import 'package:test_teknikal_fan/screens/splash_screen.dart';
import 'package:test_teknikal_fan/screens/login_screen.dart';
import 'package:test_teknikal_fan/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => EmailVarificationCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.urbanistTextTheme(),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primaryColor,
            secondary: Color(0xffFFD460),
          ),
        ),
        routes: {
          '/': (context) => const IntroductionScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
