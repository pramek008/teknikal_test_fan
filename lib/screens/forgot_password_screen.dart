import 'package:flutter/material.dart';
import 'package:test_teknikal_fan/utils/theme.dart';
import 'package:test_teknikal_fan/utils/validator.dart' as validator;
import 'package:test_teknikal_fan/widgets/btn_widget.dart';
import 'package:test_teknikal_fan/widgets/text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _emailController = TextEditingController();

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
              Text('Forgot Password?',
                  style: txBold.copyWith(
                    color: blackColor,
                    fontSize: 32,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Don\'t worry! It occurs. Please enter the email address linked with your account.',
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
                SizedBox(
                  height: 40,
                ),
                CustomButtonWidget(
                  btnName: 'Send Code',
                  width: defaultMargin,
                  statusColor: true,
                  onPressed: () {},
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
