import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          
          CupertinoIcons.arrow_left_circle_fill,
          color: AppColors.primaryColor,
          
          
          size: 40.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 375.h,
              width: 375.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(article.urlToImage ?? ''),
                    fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
