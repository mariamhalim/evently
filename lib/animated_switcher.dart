import 'package:flutter/material.dart';

class LanguageSwitcher extends StatefulWidget {
  final bool isArabic;
  final Function(bool) onToggle;

  const LanguageSwitcher({
    super.key,
    required this.isArabic,
    required this.onToggle,
  });

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher>
    with SingleTickerProviderStateMixin {
  late bool isArabic;

  @override
  void initState() {
    super.initState();
    isArabic = widget.isArabic;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isArabic = !isArabic;
        });
        widget.onToggle(isArabic);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 100,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isArabic ? Colors.green[200] : Colors.blue[200],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("🇺🇸", style: const TextStyle(fontSize: 24)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("🇪🇬", style: const TextStyle(fontSize: 24)),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isArabic
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  isArabic ? "🇪🇬" : "🇺🇸",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
