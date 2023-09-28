import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_teknikal_fan/cubit/auth_cubit.dart';
import 'package:test_teknikal_fan/cubit/email_varification_cubit.dart';
import 'package:test_teknikal_fan/screens/email_verification_screen.dart';
import 'package:test_teknikal_fan/screens/home_screen.dart';
import 'package:test_teknikal_fan/screens/login_screen.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/utils/validator.dart' as validator;
import 'package:test_teknikal_fan/widgets/btn_widget.dart';
import 'package:test_teknikal_fan/widgets/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _obscureText = true;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailVerificationCubit =
        BlocProvider.of<EmailVarificationCubit>(context);

    Widget heading() => Container(
          margin: EdgeInsets.only(
            top: 30,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: softGreyColor,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: blackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Hello! Register to get started',
                    style: txBold.copyWith(
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/icon.png',
                width: 100,
                height: 100,
              )
            ],
          ),
        );
    Widget formRegister() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Wrap(
            runSpacing: 12,
            children: [
              CustomTextFormField(
                label: 'Full Name',
                controller: _usernameController,
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return 'Username is required';
                  } else if (!validator.isValidName) {
                    return 'Username must be at least 3 characters and not contains number';
                  } else {
                    return null;
                  }
                },
              ),
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
              CustomTextFormField(
                label: 'Password',
                controller: _passwordController,
                isPassword: _obscureText,
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return 'Password is required';
                  } else {
                    final password = validator;
                    if (!password.hasUppercase()) {
                      return 'Password must be at least 1 uppercase\nPassword must be at least 1 lowercase\nPassword must be at least 1 number\nPassword must be at least 8 characters';
                    } else if (!password.hasLowercase()) {
                      return 'Password must be at least 1 lowercase\nPassword must be at least 1 number\nPassword must be at least 8 characters';
                    } else if (!password.hasDigit()) {
                      return 'Password must be at least 1 number\nPassword must be at least 8 characters';
                    } else if (!password.hasMinLength(8)) {
                      return 'Password must be at least 8 characters';
                    } else {
                      return null;
                    }
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              CustomTextFormField(
                label: 'Confirm Password',
                // controller: _passwordController,
                isPassword: _obscureText,
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return 'Confirm Password is required';
                  } else if (validator != _passwordController.text) {
                    return 'Confirm Password is not match';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          // MaterialPageRoute(builder: (context) => HomeScreen()),
                          MaterialPageRoute(
                              builder: (context) => EmailVerificationScreen()),
                          (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Register Success'),
                          backgroundColor: greenColor.withOpacity(0.5),
                        ),
                      );
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // content: Text(state.message),
                          content: Text('Waiting for process'),
                          backgroundColor: greyColor.withOpacity(0.5),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return CustomButtonWidget(
                        btnName: 'Register',
                        width: defaultMargin,
                        statusColor: true,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signUp(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  name: _usernameController.text.trim(),
                                );
                            emailVerificationCubit.sendVerificationEmail();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill the form correctly'),
                                backgroundColor: redColor.withOpacity(0.5),
                              ),
                            );
                          }
                        });
                  },
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget footer() => Container(
          margin: EdgeInsets.only(
            top: 50,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: txRegular.copyWith(
                  color: greyColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'Sign In',
                  style: txMedium.copyWith(
                    color: primaryColor,
                  ),
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
              const SizedBox(height: 30),
              formRegister(),
              SizedBox(height: 30),
              footer(),
              SizedBox(
                height: 140,
              )
            ],
          ),
        ),
      ),
    );
  }
}
