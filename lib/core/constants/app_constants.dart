import 'dart:ui';


class AppConstants {
 static const String appName = 'My App';
 static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];
}

String timeAgo(String isoDateString) {
  final dateTime = DateTime.parse(isoDateString).toLocal();
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  }
}
