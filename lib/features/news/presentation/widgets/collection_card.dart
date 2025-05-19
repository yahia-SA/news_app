import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        height: 140.h,
        width: 140.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            image: CachedNetworkImageProvider(article.urlToImage ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            article.sourceName ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body12Bold.copyWith(
              color: AppColors.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
