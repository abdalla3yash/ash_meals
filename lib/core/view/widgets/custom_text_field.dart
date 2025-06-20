import 'dart:async';

import 'package:ash_cart/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final double borderRadius;
  final Color? borderColor;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final Widget? prefixIcon;
  final bool isPassword;
  final double? contentVerticalPadding;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final FontWeight? hintWeight;
  final TextCapitalization? capitalization;
  final void Function()? onTap;
  final void Function(String? x)? onChange;
  final String? Function(String?)? validate;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextAlign textAlign;
  final String? initialValue;

  const CustomTextField(
      {this.controller,
      this.hintText,
      this.onTap,
      this.enabled = true,
      this.textInputType,
      this.hintWeight = FontWeight.w400,
      this.maxLine,
      this.maxLength,
      this.minLines,
      this.borderRadius = 8,
      this.borderColor,
      this.focusNode,
      this.contentVerticalPadding,
      this.nextNode,
      this.readOnly = false,
      this.prefixIcon,
      this.isPassword = false,
      this.suffixIcon,
      this.onChange,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.validate,
      this.floatingLabelBehavior,
      this.textAlign = TextAlign.start,
      this.initialValue,
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  Timer? _debounce;
  final _debounceDuration = const Duration(milliseconds: 500);

  void _toggle() => setState(() =>_obscureText = !_obscureText);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

   void _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      widget.onChange!(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      cursorColor: AppColors.primary,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      maxLines: widget.maxLine ?? 1,
      minLines: widget.minLines,
      keyboardType: widget.textInputType ?? TextInputType.text,
      maxLength: widget.isPhoneNumber ? 11 : widget.maxLength,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      obscuringCharacter: "*",
      obscureText: widget.isPassword ? _obscureText : false,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value); 
        }
        FocusScope.of(context).requestFocus(widget.nextNode); 
      },     
      onChanged: _onSearchChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [widget.isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
      validator: widget.validate,
      style: const TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius),borderSide: BorderSide(color: widget.borderColor ?? AppColors.grey,style: BorderStyle.solid)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius),borderSide: BorderSide(color: widget.borderColor ?? AppColors.grey,style: BorderStyle.solid)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius),borderSide: BorderSide( color: widget.borderColor ?? AppColors.grey, style: BorderStyle.solid)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius), borderSide: BorderSide( color: widget.borderColor ?? AppColors.grey, style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius), borderSide: BorderSide(color: widget.borderColor ?? AppColors.grey, style: BorderStyle.solid)),
        floatingLabelBehavior: widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,
        alignLabelWithHint: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: widget.contentVerticalPadding ?? 14, horizontal: 15),
        filled: true,
        fillColor: widget.fillColor ?? AppColors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword ? IconButton( icon: _obscureText ? const Icon(Icons.visibility_outlined,color: AppColors.hintTextColor) : const Icon(Icons.visibility_off_outlined,color: AppColors.hintTextColor), onPressed: _toggle) : widget.suffixIcon,
        suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        counterText: '',
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: const TextStyle(color: AppColors.black),
        isCollapsed: true, 
        hintText: widget.hintText, 
        hintStyle: TextStyle(color: AppColors.hintTextColor,  fontWeight: widget.hintWeight),
        errorStyle: const TextStyle(height: 1),
        border: InputBorder.none,
      ),
    );
  }
}
