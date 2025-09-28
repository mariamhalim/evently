import 'package:flutter/material.dart';

class LanguageToggle extends StatefulWidget {
  final VoidCallback? onEnglishSelected;
  final VoidCallback? onArabicSelected;

  const LanguageToggle({
    Key? key,
    this.onEnglishSelected,
    this.onArabicSelected,
  }) : super(key: key);

  @override
  _LanguageToggleState createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnglish = !isEnglish;
        });
        if (isEnglish) {
          widget.onEnglishSelected?.call();
        } else {
          widget.onArabicSelected?.call();
        }
      },
      child: Container(
        width: 140,
        height: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            // Animated moving circle (flag background)
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: isEnglish
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  image: DecorationImage(
                    image: AssetImage(
                      isEnglish
                          ? "assets/images/usa.png"
                          : "assets/images/egypt.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // The flags as background (fixed, for visual effect)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/EG.png"),
                Image.asset("assets/images/LR.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
