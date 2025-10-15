import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  String tapItemName;
  bool isSelected;
  Color selectedBgColor;
  TextStyle? selectedTextColor;

  EventTabItem({
    super.key,
    required this.tapItemName,
    required this.isSelected,
    required this.selectedBgColor,
    required this.selectedTextColor
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.005,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.01,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: isSelected ? selectedBgColor : AppColors.trancColor,
        border: Border.all(color: Theme.of(context).focusColor, width: 2),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Text(
            tapItemName,
            style: isSelected
                ? selectedTextColor
                : AppStyles.MidWight16,
          ),
        ],
      ),
    );
  }
}
