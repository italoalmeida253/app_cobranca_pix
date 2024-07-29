import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:io' show Platform;

enum AppInputTypes {
  solid,
  outline,
}

class AppInput extends StatefulWidget {
  final String hintText;
  final AppInputTypes type;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final String? iconAssetName;
  final MaskTextInputFormatter? inputMask;
  final TextInputType? keyboardType;

  const AppInput(
      {super.key,
      required this.hintText,
      this.type = AppInputTypes.solid,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onChanged,
      this.iconAssetName,
      this.inputMask});

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  FocusNode inputFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Color hintColor;
    late Color textColor;
    
    switch (widget.type) {
      case AppInputTypes.outline:
        backgroundColor = Colors.transparent;
        hintColor = Theme.of(context).inputDecorationTheme.hintStyle!.color!;
        textColor = Colors.white;
        break;
      case AppInputTypes.solid:
        backgroundColor = Colors.white;
        hintColor = terciaryColor;
        textColor = Colors.black;
        break;
    }

    return GestureDetector(
      onTap: () {
        inputFocusNode.requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
              width: 1,
            )),
        child: Row(
          children: [
            if (widget.iconAssetName != null)
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: AppIcon(
                  assetName: widget.iconAssetName!,
                  color: hintColor,
                  height: 20,
                ),
              ),
            Expanded(
                child: TextField(
                  onTapOutside: (event) {
                    if (Platform.isIOS) {
                      inputFocusNode.unfocus();
                    }
                  },
                  controller: widget.controller,
                  onChanged: (value) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  },
                  keyboardType: widget.keyboardType,
              inputFormatters:
                  widget.inputMask != null ? [widget.inputMask!] : [],
              style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                    color: textColor,
                  )),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.sora(
                      textStyle: TextStyle(fontSize: 14, color: hintColor))),
              focusNode: inputFocusNode,
            ))
          ],
        ),
      ),
    );
  }
}
