import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/collection_card.dart';
import 'package:news_app/features/news/presentation/widgets/news_app_bar.dart';
import 'package:news_app/features/news/presentation/widgets/news_item.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: NewsAppBar(actionIcon: CupertinoIcons.search_circle),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(32),
            Text(
              'collections'.tr(),
              style: AppTextStyles.heading36Bold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            verticalSpace(20),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial || state is NewsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NewsLoaded) {
                  final bookmarkedArticles =
                      state.articles
                          .where(
                            (article) => state.bookmarkedArticles.contains(
                              article.title,
                            ),
                          )
                          .toList();

                  if (bookmarkedArticles.isEmpty) {
                    return SizedBox(
                      height: 140.h,
                      child: Center(
                        child: Text(
                          'no_bookmarks'.tr(),
                          style: AppTextStyles.body12Regular.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 26.sp,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 140.h,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: bookmarkedArticles.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final article = bookmarkedArticles[index];
                          return CollectionCard(article: article);
                        },
                      ),
                    );
                  }
                }

                if (state is NewsError) {
                  return Center(child: Text(state.message));
                }

                return Container();
              },
            ),
            verticalSpace(32),
            Text(
              'latest_bookmarks'.tr(),
              style: AppTextStyles.body12Regular.copyWith(
                color: AppColors.primaryColor,
                fontSize: 26.sp,
              ),
            ),
            verticalSpace(16),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsInitial || state is NewsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is NewsLoaded) {
                    final bookmarkedArticles =
                        state.articles
                            .where(
                              (article) => state.bookmarkedArticles.contains(
                                article.title,
                              ),
                            )
                            .toList();

                    if (bookmarkedArticles.isEmpty) {
                      return Padding(
                        padding:  EdgeInsetsDirectional.only(bottom: 200.h),
                        child: Center(
                          child: Text(
                            'no_bookmarks'.tr(),
                            style: AppTextStyles.body12Regular.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 26.sp,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: bookmarkedArticles.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final article = bookmarkedArticles[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Dismissible(
                              key: Key(article.title ?? ''),
                              onDismissed: (direction) {
                                context.read<NewsBloc>().add(
                                  RemoveBookmark(article.title!),
                                );
                              },
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.transparent,

                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.w),
                                child: Icon(
                                  CupertinoIcons.clear_circled,
                                  color: AppColors.primaryColor,
                                  size: 22.sp,
                                ),
                              ),

                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(20, 30, 40, 0.16),
                                      offset: Offset(0, 10),
                                      blurRadius: 32,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: NewsItem(article: article),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }

                  if (state is NewsError) {
                    return Center(child: Text(state.message));
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
