import 'package:flutter/material.dart';

import '../../style.dart';

class DefaultTextFormField extends StatefulWidget {
  bool enabled;
  int? maxLength;
  Function(String)? onChanged;
  FocusNode? focusNode;
  TextEditingController? controller;
  TextDirection textDeirection;
  TextAlign textAlign;
  Color cursorColor;
  int maxLines;
  String? hintText;
  String? error;

  DefaultTextFormField({
    this.maxLength,
    this.onChanged,
    this.focusNode,
    this.controller,
    this.hintText,
    this.error,
    this.textDeirection = TextDirection.rtl,
    this.textAlign = TextAlign.right,
    this.cursorColor = Colors.black,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  _DefaultTextFormFieldState createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      textDirection: widget.textDeirection,
      textAlign: widget.textAlign,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      style: defaultTextFormFieldStyle,
      decoration: InputDecoration(
        errorText: widget.error,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusColor: Colors.black,
        hintStyle: hintStyle,
        hintText: widget.hintText,
        errorStyle: addTaskDialogError,
      ),
    );
  }

  bool isEmpty() {
    if (widget.controller!.text == '') {
      return false;
    }
    return true;
  }
}
