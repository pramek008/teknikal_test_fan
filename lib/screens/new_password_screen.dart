import 'package:flutter/material.dart';
import 'package:test_teknikal_fan/screens/home_screen.dart';
import 'package:test_teknikal_fan/screens/login_screen.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/utils/validator.dart' as validator;
import 'package:test_teknikal_fan/widgets/btn_widget.dart';
import 'package:test_teknikal_fan/widgets/text_form_field.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late bool _obscureText = true;
    final _passwordController = TextEditingController();

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
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: blackColor,
                  ),
                ),
              ),
              Text('Create new password',
                  style: txBold.copyWith(
                    color: blackColor,
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Your new password must be unique from those previously used.',
                  style: txMedium.copyWith(
                    color: greyColor,
                  )),
            ],
          ),
        );

    Widget inputForm() => Container(
          margin: EdgeInsets.only(
            top: 32,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CustomTextFormField(
                  label: 'New Password',
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
                  child: CustomButtonWidget(
                      btnName: 'Register',
                      width: defaultMargin,
                      statusColor: true,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill the form correctly'),
                              backgroundColor: redColor.withOpacity(0.5),
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              heading(),
              inputForm(),
            ],
          ),
        ),
      ),
    );
  }
}
