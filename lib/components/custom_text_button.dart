import 'package:flutter/material.dart';
import 'package:image2pdf/data/constants/app_colors.dart';

class CustomTextButton extends StatefulWidget {
  final String text;

  final bool isLoading;

  final Function onClick;

  final dynamic leadIcon;

  const CustomTextButton(
      {super.key,
      required this.text,
      this.leadIcon,
      this.isLoading = false,
      required this.onClick});

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(appColors.appLightColor)),
      onPressed: () {
        widget.onClick();
      },
      label: Text(
        !widget.isLoading ? widget.text : 'Processing',
        style: TextStyle(color: Colors.white),
      ),
      icon: widget.isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                strokeWidth: 5,
              ),
            )
          : widget.leadIcon != null
              ? Icon(widget.leadIcon)
              : null,
    );
  }
}
