import 'package:flutter/material.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';

class HoverTextIconButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const HoverTextIconButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, hovering, _) {
          return TextButton.icon(
            onPressed: onTap,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: Icon(
              Icons.help_outline,
              size: 14,
              color: hovering ? AppColors.black : AppColors.white,
            ),
            label: Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: hovering ? AppColors.black : AppColors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

class HoverTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const HoverTextButton({super.key, required this.text, required this.onTap});

  @override
  State<HoverTextButton> createState() => _HoverTextButtonState();
}

class _HoverTextButtonState extends State<HoverTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 0),
          style: TextStyle(
            color: _isHovered ? AppColors.fontGrey : AppColors.white,
            fontSize: 12.25,
            fontWeight: FontWeight.w400,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
