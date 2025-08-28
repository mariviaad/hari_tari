import 'package:flutter/material.dart';

class PanelContent extends StatelessWidget {
  const PanelContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFF1D293D),
        boxShadow: const [
          BoxShadow(color: Color(0xFF314158), offset: Offset(0, 10)),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildDotRow(), const SizedBox(height: 2), _buildDotRow()],
        ),
      ),
    );
  }

  Widget _buildDotRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (_) {
        return Container(
          width: 3.75,
          height: 3.75,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: const BoxDecoration(
            color: Color(0xE699A1AF),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
