import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_teknikal_fan/cubit/auth_cubit.dart';
import 'package:test_teknikal_fan/screens/forgot_password_screen.dart';
import 'package:test_teknikal_fan/screens/home_screen.dart';
import 'package:test_teknikal_fan/screens/register_screen.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/utils/validator.dart' as validator;
import 'package:test_teknikal_fan/widgets/btn_widget.dart';
import 'package:test_teknikal_fan/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget heading() => Container(
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            Text('Welcome back! Glad to see you, Again!',
                style: txBold.copyWith(
                  color: blackColor,
                )),
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/icon.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      );

  Widget formLogin() {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        left: defaultMargin,
        right: defaultMargin,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Email',
              controller: _emailController,
              validator: (validator) {
                if (validator!.isEmpty) {
                  return 'Email is required';
                } else if (!validator.isValidEmail) {
                  return 'Email is not valid';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextFormField(
                  label: 'Password',
                  controller: _passwordController,
                  isPassword: _obscureText,
                  validator: (validator) {
                    if (validator!.isEmpty) {
                      return 'Password is required';
                    } else {
                      final password = validator;
                      if (!password.hasMinLength(8)) {
                        return 'Password must be at least 8 characters';
                      } else {
                        return null;
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: txMedium.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 45,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: redColor.withOpacity(0.7),
                    ),
                  );
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: redColor.withOpacity(0.7),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return CustomButtonWidget(
                    btnName: 'Login',
                    btnColor: blackColor,
                    width: defaultMargin,
                    statusColor: true,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill the form correctly'),
                            backgroundColor: redColor.withOpacity(0.7),
                          ),
                        );
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget footer() => Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account? ',
              style: txRegular.copyWith(
                color: greyColor,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                'Sign Up',
                style: txMedium.copyWith(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            heading(),
            formLogin(),
            SizedBox(
              height: 110,
            ),
            footer(),
          ],
        ),
      )),
    );
  }
}
