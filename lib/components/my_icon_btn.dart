import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Widget icon;
  const MyIconButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade300,
                    Colors.orange,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: icon,
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          )
        ],
      ),
    );
  }
}
