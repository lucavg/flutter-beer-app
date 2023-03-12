import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class CensoredInputField extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final bool enabled;

  const CensoredInputField(
      {Key? key,
        required this.hint,
        required this.onChanged,
        this.controller,
        this.enabled = true})
      : super(key: key);

  @override
  CensoredInputFieldState createState() => CensoredInputFieldState();
}

class CensoredInputFieldState extends State<CensoredInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
      childBuilderTheme: (context, theme) => TextField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          filled: true,
          hintStyle: theme.coreTextTheme.bodyNormal.copyWith(color: theme.colorsTheme.inputFieldHint),
          fillColor: theme.colorsTheme.inputFieldFill,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorsTheme.inputFieldBorderEnabled),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorsTheme.inputFieldBorderFocused),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorsTheme.bottomNavbarItemInactive),
          ),
          hintText: widget.hint,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        style: theme.coreTextTheme.bodyNormal,
        controller: widget.controller,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
      ),
    );
  }
}
