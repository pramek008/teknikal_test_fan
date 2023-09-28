import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_teknikal_fan/utils/theme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      this.hint,
      this.isPassword,
      this.inputFormatters,
      this.validator,
      this.controller,
      this.onChanged});
  final String label;
  final String? hint;
  final bool? isPassword;
  final Function(bool?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      obscureText: widget.isPassword != null ? _obscureText : false,
      obscuringCharacter: '*',
      cursorColor: primaryColor,
      decoration: InputDecoration(
        labelText: widget.label,
        errorMaxLines: 5,
        hintText: widget.hint,
        suffixIcon: widget.isPassword != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(_obscureText);
                  }
                },
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ))
            : null,
        filled: true,
        fillColor: softGreyColor.withOpacity(0.5),
        hintStyle: txRegular.copyWith(
          color: greyColor,
        ),
        labelStyle: txMedium.copyWith(
          color: greyColor,
        ),
        floatingLabelStyle: txMedium.copyWith(
          color: primaryColor,
        ),
        errorStyle: txRegular.copyWith(
          color: redColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: darklGreyColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: redColor,
          ),
        ),
      ),
    );
  }
}
