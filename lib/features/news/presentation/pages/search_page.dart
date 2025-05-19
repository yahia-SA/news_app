import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/extensions/sizedbox_extensions.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/core/themes/app_text.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/news_section.dart';
import 'package:news_app/features/news/presentation/widgets/video_section.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial || state is NewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsLoaded) {
          if (state.articles.isEmpty) {
            return Center(
              child: Text(
                'no_results'.tr(),
                style: AppTextStyles.body16Regular.copyWith(
                  color: AppColors.shadowColor,
                ),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0.w),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verticalSpace(40),
                  SizedBox(
                    width: 311.w,
                    child: TextField(
                      controller: searchController,

                      onSubmitted: (value) {
                        context.read<NewsBloc>().add(SearchNews(value));
                      },
                      decoration: InputDecoration(
                        fillColor: AppColors.primaryColor,
                        filled: true,

                        suffixIcon: GestureDetector(
                          child: Icon(
                            CupertinoIcons.search_circle_fill,
                            color: AppColors.backgroundColor,
                            size: 40.sp,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.r),

                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.r),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.r),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        hintText: 'search'.tr(),
                        hintStyle: AppTextStyles.body14Regular.copyWith(
                          color: AppColors.backgroundColor,
                        ),
                      ),
                      style: AppTextStyles.body14Bold.copyWith(
                        color: AppColors.backgroundColor,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  verticalSpace(32),
                  VideoSection(
                    videos:
                        state.articles
                            .where((article) => article.url!.contains('video'))
                            .toList(),
                  ),
                  verticalSpace(32),
                  Expanded(child: NewsSection(news: state.articles)),
                ],
              ),
            ),
          );
        } else if (state is NewsError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('error'.tr()));
        }
      },
    );
  }
}
