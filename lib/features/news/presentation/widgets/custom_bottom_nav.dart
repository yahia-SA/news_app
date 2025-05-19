import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/news/presentation/pages/bookmarks_page.dart';
import 'package:news_app/features/news/presentation/pages/home_page.dart';
import 'package:news_app/features/news/presentation/pages/search_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const BookmarksPage(),
     SearchPage(),
    const Center(child:  Text('Notifications')),
    const Center(child:  Text('Settings')),
  ];
  final List<IconData> icons = [
    Icons.home_outlined,
    Icons.bookmark_border,
    Icons.search_outlined,
    Icons.notifications_none_outlined,
    Icons.settings_outlined,
  ];
  void _handleTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        extendBody: true,

      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        icons: icons,
        currentIndex: _currentIndex,
        onTap: _handleTap,
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  });

  final int currentIndex;
  final Function(int) onTap;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 44.0.w, right: 44.0.w, bottom: 40.0.h),
      child: Container(
        height: 56.0.h,
        decoration: BoxDecoration(
          color: Colors.white,
          
          borderRadius: BorderRadius.circular(28.0.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(20, 30, 40, 0.16),
              offset: const Offset(0, 16),
              blurRadius: 40.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () => onTap(index),
                child: Icon(
                  icons[index],
                  size: 26.sp,
                  color:
                      currentIndex == index
                          ? Colors.black
                          : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
