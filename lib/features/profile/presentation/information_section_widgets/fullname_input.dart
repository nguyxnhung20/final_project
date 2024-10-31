import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? currentValue;
  final void Function(String)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;

  const TextInput({
    super.key,
    required this.currentValue,
    this.onChanged,
    required this.hintText,
    this.keyboardType,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: _controller,
        keyboardType: widget.keyboardType,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xff6D9EFF).withOpacity(.1),
                ),
                borderRadius: BorderRadius.circular(12)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff6D9EFF),
                ),
                borderRadius: BorderRadius.circular(12)),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white)),
        onChanged: widget.onChanged,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Nếu giá trị currentValue thay đổi, cập nhật lại controller
    if (widget.currentValue != oldWidget.currentValue) {
      _controller.text = widget.currentValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }
}
