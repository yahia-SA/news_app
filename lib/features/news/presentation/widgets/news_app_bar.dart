import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Icon(
        CupertinoIcons.line_horizontal_3_decrease_circle_fill,
        color: AppColors.primaryColor,
        size: 40.sp,
      ),
      actions: [
        Icon(
          CupertinoIcons.mic_circle,
          size: 40.sp,
          color: AppColors.primaryColor,
        ),
      ],

      title: RichText(
        text: TextSpan(
          text: 'News',
          style: AppTextStyles.body12Bold.copyWith(
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
          children: [
            TextSpan(
              text: 'App',
              style: AppTextStyles.thin16.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0.h);
}
