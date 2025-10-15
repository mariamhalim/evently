import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class DateOrTimeWidget extends StatelessWidget {
  final IconData iconName;
  final String textDate;
  final String textTime;
  final VoidCallback onChooseDateOrTime;

  const DateOrTimeWidget({
    super.key,
    required this.iconName,
    required this.textDate,
    required this.textTime,
    required this.onChooseDateOrTime,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Row(
      children: [
        Icon(iconName, color: Theme.of(context).cardColor),
        SizedBox(width: width * 0.03),
        Text(textTime, style: Theme.of(context).textTheme.headlineMedium),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTime,
          child: Text(textDate, style: AppStyles.MidBluet16),
        ),
      ],
    );
  }
}
