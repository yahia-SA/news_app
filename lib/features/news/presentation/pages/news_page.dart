import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/custom_bottom_nav.dart';
import 'package:news_app/features/news/presentation/widgets/news_app_bar.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return _NewsPageContent(article: article);
  }
}

class _NewsPageContent extends StatefulWidget {
  final Article article;
  const _NewsPageContent({required this.article});

  @override
  State<_NewsPageContent> createState() => __NewsPageContentState();
}

class __NewsPageContentState extends State<_NewsPageContent> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: NewsAppBar(isnews: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  image: CachedNetworkImageProvider(
                    widget.article.urlToImage ?? '',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 32.0.w,
                right: 32.0.w,
                top: 32.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage:
                            Image.asset(
                              'assets/images/avatar.jpg',
                              fit: BoxFit.cover,
                            ).image,
                      ),
                      horizontalSpace(6),
                      Expanded(
                        child: Text(
                          widget.article.author ?? 'Unknown Author',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body14Regular.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(32),
                  // Source
                  Text(
                    widget.article.sourceName ?? 'Unknown Source',
                    style: AppTextStyles.heading36Bold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.shadowColor,
                    ),
                  ),
                  verticalSpace(14),
                  // Title
                  Text(
                    widget.article.title ?? '',
                    style: AppTextStyles.heading22ExtraBold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(16),
                  // Date
                  Text(
                    widget.article.publishedAt != null
                        ? DateFormat(
                          'd MMMM, yyyy — h:mm a',
                        ).format(DateTime.parse(widget.article.publishedAt!))
                        : '',
                    style: AppTextStyles.body12Regular.copyWith(
                      color: AppColors.shadowColor,
                    ),
                  ),
                  verticalSpace(30),
                  // Separator
                  Container(
                    height: 2.h,
                    width: double.infinity,
                    color: AppColors.shadowColor,
                  ),
                  verticalSpace(32),
                  // Description
                  Text(
                    widget.article.description ?? '',
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          final isBookmarked =
              state is NewsLoaded
                  ? state.bookmarkedArticles.contains(widget.article.title)
                  : false;

          return CustomBottomNav(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() => currentIndex = index);
              if (index == 1) {
                final bloc = context.read<NewsBloc>();

                if (isBookmarked) {
                  bloc.add(RemoveBookmark(widget.article.title!));
                  log('bookmark removed');
                } else {
                  bloc.add(
                    AddBookmark(ArticleModel.fromEntity(widget.article)),
                  );
                  log('bookmark added');
                }
              }
            },
            icons: [
              CupertinoIcons.chat_bubble_text,
              state is NewsLoaded &&
                      state.bookmarkedArticles.contains(widget.article.title)
                  ? CupertinoIcons.bookmark_fill
                  : CupertinoIcons.bookmark,
              CupertinoIcons.arrowshape_turn_up_right,
            ],
          );
        },
      ),
    );
  }
}
