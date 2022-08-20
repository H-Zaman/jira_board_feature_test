import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  final String? hint;
  final String? title;
  final TextEditingController? controller;
  final Color borderColor;
  final Color fillColor;
  final int? maxLines;
  final bool password;
  const CTextField({
    Key? key,
    this.borderColor = Colors.white,
    this.fillColor = Colors.white,
    this.controller,
    this.hint,
    this.title,
    this.password = false,
    this.maxLines,
  }) : super(key: key);

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {

  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title != null) Text(
          widget.title!,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff212529),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            TextField(
              obscureText: showPassword,
              controller: widget.controller,
              maxLines: widget.password ? 1 : widget.maxLines,
              cursorColor: Colors.black,
              textInputAction: widget.maxLines != null && widget.maxLines! > 1 ? TextInputAction.newline : TextInputAction.done,
              scrollPadding: const EdgeInsets.only(bottom:40),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: widget.borderColor, width: 1.5
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: widget.borderColor, width: 1.5
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: widget.borderColor, width: 1.5
                  )
                ),
                filled: true,
                hintStyle: TextStyle(
                  color: const Color(0xff868E96),
                  fontSize: 16
                ),
                hintText: widget.hint,
                fillColor: widget.fillColor,
              ),
            ),
            if(widget.password) Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: (){
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                constraints: BoxConstraints(),
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off_outlined
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}