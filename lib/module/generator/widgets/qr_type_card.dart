import 'package:flutter/material.dart';

class QRTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  final Color iconColor;

  const QRTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: selected ? const Color(0xff6C4DFF) : const Color(0xff1F1F23),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? const Color(0xff6C4DFF) : Colors.white10,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: selected ? Colors.white : iconColor,
                ),

                const SizedBox(height: 10),

                Text(
                  title,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
