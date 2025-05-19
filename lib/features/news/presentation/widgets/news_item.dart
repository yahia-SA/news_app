import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/routing/navigator_services.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  const NewsItem({super.key, required this.article,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>NavigationService.pushNamed(Routes.news,arguments: article),
      child: Card(
        elevation: 0,
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
                placeholder:
                    (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) =>
                        Icon(Icons.error_outline, color: Colors.red),
              ),
            ),
            horizontalSpace(24),
            // Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Category
                  Text(
                    article.sourceName!.toUpperCase(),
                    style: AppTextStyles.heading18Bold.copyWith(
                      color: AppColors.shadowColor,
                      fontSize: 12.sp,
                      height: 1.h,
                    ),
                  ),
                  verticalSpace(6),
                  // Title
                  Text(
                    article.title ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading18Bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  
                  // // Description (Optional)
                  // if (article.description != null && article.description!.isNotEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 12),
                  //     child: Text(
                  //       article.description!,
                  //       maxLines: 2,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(color: Colors.grey[700]),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
