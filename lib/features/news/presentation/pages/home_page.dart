import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/card.dart';
import 'package:news_app/features/news/presentation/widgets/news_app_bar.dart';
import 'package:news_app/features/news/presentation/widgets/news_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      appBar: NewsAppBar(ishome: true),

      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial || state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NewsLoaded) {
            return Padding(
              padding: EdgeInsets.only(
                left: 32.0.w,
                right: 32.0.w,
                top: 32.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 311.h,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        final isBookmarked = state.bookmarkedArticles.contains(
                          article.title,
                        );
                        return NewsCard(
                          article: article,
                          isBookmarked: isBookmarked,
                          onCommentTap: () {
                            // Handle comment action
                            log('Comment tapped for ${article.title}');
                          },
                          onBookmarkTap: () {
                            // Handle bookmark action
                            final bloc = context.read<NewsBloc>();
                            if (isBookmarked) {
                              bloc.add(RemoveBookmark(article.title!));
                              log('Bookmark Removed');
                            } else {
                              bloc.add(
                                AddBookmark(ArticleModel.fromEntity(article)),
                              );
                              log('Bookmark Added');
                            }
                          },
                          onShareTap: () {
                            // Handle share action
                            log('Share tapped for ${article.title}');
                          },
                        );
                      },
                    ),
                  ),
                  verticalSpace(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'latest_News'.tr(),
                        style: AppTextStyles.body14Regular.copyWith(
                          color: AppColors.shadowColor,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.arrow_right_circle,
                        size: 16.sp,

                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  verticalSpace(23),
                  Expanded(
                    child: SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        itemCount: state.articles.length ,
                        scrollDirection: Axis.vertical,

                        itemBuilder: (context, index) {
                          final article = state.articles[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: NewsItem(article: article),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
