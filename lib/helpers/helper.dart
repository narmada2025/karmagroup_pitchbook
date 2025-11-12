import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pitchbook/config/config.dart';
import 'package:pitchbook/constants/custom_snackbar.dart';
import 'package:pitchbook/src/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

//check internet
Future<bool> checkInternetAvailability() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  bool isOnline = false;

  if (!connectivityResult.contains(ConnectivityResult.none)) {
    isOnline = true;
  }
  return isOnline;
}

//check login status
Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

//logout
Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);

  final cookieManager = WebViewCookieManager();
  await cookieManager.clearCookies();

  if (context.mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

//Fetch API
Future<dynamic> fetchAPIData(String url, {bool isMap = false}) async {
  log("====Apiii Chairmen-Session $url");
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (isMap) {
        List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> dataMap = jsonDecode(response.body);
        return dataMap;
      }
    } else {
      log('Failed to load gallery data: ${response.statusCode}');
      return isMap ? [] : {};
    }
  } catch (e) {
    log('Error fetching gallery data: $e');
    return isMap ? [] : {};
  }
}

// fetch local JSON from asset
Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  final jsonString = await rootBundle.loadString(filePath);
  final jsonData = jsonDecode(jsonString);
  return jsonData;
}

//launch url
Future<void> launchUrlInBrowser(BuildContext context, String urlString) async {
  try {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    if (context.mounted) {
      CustomSnackBar(
        message: 'Error launching URL: $e',
        context: context,
      );
    }
  }
}

//load pdf from assets
Future<String> loadPdfFromAssets(String assetPath) async {
  final ByteData bytes = await rootBundle.load(assetPath);
  final String dir = (await getTemporaryDirectory()).path;
  final File file = File('$dir/${assetPath.split('/').last}');
  await file.writeAsBytes(bytes.buffer.asUint8List());
  return file.path;
}

//fetch youtube playlist using youtube data api v3
class PlaylistCache {
  final Map<String, List<Map<String, dynamic>>> _cache = {};

  Future<List<Map<String, dynamic>>> fetchPlaylistItems(
      String playlistId) async {
    log("====playlistId $playlistId");
    if (_cache.containsKey(playlistId)) {
      return _cache[playlistId]!;
    }

    const apiKey = youtubeAPI;
    List<Map<String, dynamic>> playlistItems = [];
    String nextPageToken = '';

    try {
      do {
        final url =
            'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&pageToken=$nextPageToken&playlistId=$playlistId&key=$apiKey';
        log("======url === $url");
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          nextPageToken = data['nextPageToken'] ?? '';

          for (var item in data['items'] ?? []) {
            final snippet = item['snippet'];
            final thumbnails = snippet['thumbnails'];

            if (snippet['title'] == 'Private video' ||
                snippet['description'] == 'This video is private.') {
              continue;
            }

            playlistItems.add({
              'title': snippet['title'] ?? 'Untitled',
              'video': snippet['resourceId']?['videoId'] ?? '',
              'cover': thumbnails['medium']?['url'] ?? '',
            });
          }
        } else {
          throw Exception(
              'Failed to fetch playlist items: ${response.statusCode}');
        }
      } while (nextPageToken.isNotEmpty);

      _cache[playlistId] = playlistItems;
      return playlistItems;
    } catch (e) {
      throw Exception('Failed to fetch playlist items');
    }
  }
}
