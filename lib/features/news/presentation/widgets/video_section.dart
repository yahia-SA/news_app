import 'package:cached_network_image/cached_network_image.dart';
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

class VideoSection extends StatelessWidget {
  const VideoSection({super.key, required this.videos});

  final List<Article> videos;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${videos.length} Videos'.tr(),
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

        SizedBox(
          height: 140.h,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => horizontalSpace(24),
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return GestureDetector(
                onTap: () => NavigationService.pushNamed(Routes.news,arguments: video.url),
                child: Container(
                  height: 140.h,
                  width: 224.w,
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(video.urlToImage ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 16.0.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.play_circle,
                          color: AppColors.backgroundColor,
                          size: 22.sp,
                        ),
                        Spacer(),
                        Text(
                          video.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body16Regular.copyWith(
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
