import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/routing/navigator_services.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key, required this.news});

  final List<Article> news;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${news.length} News'.tr(),
              style: AppTextStyles.body12Regular.copyWith(
                fontSize: 24.sp,
                color: AppColors.primaryColor,
              ),
            ),
            Icon(
              CupertinoIcons.arrow_right_circle,
              color: Colors.black,
              size: 13.48.sp,
            ),
          ],
        ),
        verticalSpace(24),

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => verticalSpace(24),
              itemCount: news.length,
              itemBuilder: (context, index) {
                final newsItem = news[index];
                return GestureDetector(
                  onTap: () => NavigationService.pushNamed(Routes.news,arguments: newsItem),
                  child: Text(
                    newsItem.title ?? ' ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
