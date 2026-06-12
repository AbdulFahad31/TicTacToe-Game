import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const GameCell({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = value.isEmpty;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEmpty 
              ? Colors.grey.shade900.withOpacity(0.5) 
              : (value == 'X' 
                  ? Colors.blue.withOpacity(0.1) 
                  : Colors.pink.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isEmpty 
                ? Colors.white.withOpacity(0.08) 
                : (value == 'X' ? Colors.blue.shade400 : Colors.pink.shade400),
            width: isEmpty ? 1.5 : 2.5,
          ),
          boxShadow: isEmpty
              ? []
              : [
                  BoxShadow(
                    color: value == 'X'
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.pink.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ],
        ),
        child: Center(
          child: AnimatedScale(
            scale: isEmpty ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: value == 'X' ? Colors.blue.shade300 : Colors.pink.shade300,
                shadows: [
                  Shadow(
                    color: value == 'X' 
                        ? Colors.blue.withOpacity(0.8) 
                        : Colors.pink.withOpacity(0.8),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}