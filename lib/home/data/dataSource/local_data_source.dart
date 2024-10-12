import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveVideosToPrefs(List<String> videos) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('videoUrls', videos);
}

Future<List<String>> loadVideosFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('videoUrls') ?? [];
}
