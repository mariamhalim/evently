import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.blueColor),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(AppAssets.birthDay),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).dividerColor,
                ),
                child: Column(
                  children: [
                    Text('22', style: AppStyles.bold20Blue),
                    Text('Nov', style: AppStyles.bold16Blue),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: height * 0.05,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).dividerColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Row(
                    children: [
                      Text(
                        'This is a Birthday Party ',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.heart_solid,
                        color: AppColors.blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
