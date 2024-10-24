import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/app_colors.dart';

class TxtField extends StatefulWidget {
  const TxtField({
    super.key,
    required this.controller,
    this.multiline = false,
    this.number = false,
    this.length = 20,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool multiline;
  final bool number;
  final int length;
  final void Function() onChanged;

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  double _height() {
    if (widget.multiline) return 170;
    return 48;
  }

  int? _maxLines() {
    if (widget.multiline) return null;
    return 1;
  }

  TextInputType? _keyboardType() {
    if (widget.multiline) return TextInputType.multiline;
    if (widget.number) return TextInputType.number;
    return null;
  }

  List<TextInputFormatter>? _inputFormatters() {
    final length = LengthLimitingTextInputFormatter(widget.length);
    final digit = FilteringTextInputFormatter.digitsOnly;
    if (widget.number) return [length, digit];
    return [length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height(),
      decoration: BoxDecoration(
        color: const Color(0xff363636),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: _keyboardType(),
        maxLines: _maxLines(),
        inputFormatters: _inputFormatters(),
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(
          color: AppColors.white,
          fontFamily: Fonts.regular,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 22,
          ),
          hintText: 'Enter Here',
          hintStyle: TextStyle(
            color: AppColors.white34,
            fontFamily: Fonts.regular,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          widget.onChanged();
        },
      ),
    );
  }
}
