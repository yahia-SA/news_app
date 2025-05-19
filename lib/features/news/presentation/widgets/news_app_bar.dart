import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({super.key, this.leadingIcon,  this.actionIcon, this.actionbutton, this.isnews = false, this.ishome = false});
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final VoidCallback? actionbutton;
  final bool isnews;
  final bool ishome;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: !isnews ? AppColors.backgroundColor : Colors.transparent,
      leading: !isnews? Icon(
        leadingIcon ?? CupertinoIcons.line_horizontal_3_decrease_circle_fill,
        color: AppColors.primaryColor,
        size: 40.sp,
      ):IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_left_circle,
                  color: AppColors.backgroundColor,
                  size: 40.sp,
                ),
                Icon(
                  CupertinoIcons.arrow_left_circle_fill,
                  color: AppColors.primaryColor,
                  size: 40.sp,
                ),
              ],
            ),
          ),
       actions:   !isnews ? [
         GestureDetector(
           onTap: actionbutton,
           child: Icon(
            actionIcon ?? CupertinoIcons.mic_circle,
            size: 40.sp,
            color: AppColors.primaryColor,
                   ),
         ),
      ]:[],
    
       title: ishome ? RichText(
        text: TextSpan(
          text: 'news'.tr(),
          style: AppTextStyles.body12Bold.copyWith(
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
          children: [
            TextSpan(
              text: 'app'.tr(),
              style: AppTextStyles.thin16.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ) : Text(''),
      centerTitle: true,
    );
    return !isnews ? Padding(padding: EdgeInsets.symmetric(horizontal: 32.w), child: appBar) : appBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0.h);
}
