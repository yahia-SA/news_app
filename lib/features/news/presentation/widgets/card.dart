import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
    this.onCommentTap,
    this.onShareTap,
    this.onBookmarkTap,
    this.onTap,
  });

  final Article article;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: SizedBox(
          height: 311.h,
          width: 311.w,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: CachedNetworkImageProvider(article.urlToImage ?? ''),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x4D000000), // 30% black
                    Color(0x99000000), // 60% black
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source & Timestamp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.sourceName?.toUpperCase() ?? '',
                        style: AppTextStyles.body12Bold.copyWith(
                          color: AppColors.backgroundColor,
                        ),
                      ),
                      Text(
                        timeAgo(article.publishedAt ?? '3 min ago'),
                        style: AppTextStyles.body12Regular.copyWith(
                          color: AppColors.backgroundColor,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
      
                  Spacer(),
      
                  // Title
                  Text(
                    article.title ?? '',
                    style: AppTextStyles.heading18Bold.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
      
                  verticalSpace(24),
      
                  // Actions
                  Padding(
                    padding: EdgeInsets.only(right: 10.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.chat_bubble_text,
                            color: Colors.white,
                          ),
                          onPressed: onCommentTap,
                        ),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.bookmark,
                            color: Colors.white,
                          ),
                          onPressed: onBookmarkTap,
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.arrowshape_turn_up_right,
                            color: Colors.white,
                          ),
                          onPressed: onShareTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
