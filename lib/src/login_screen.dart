import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late WebViewController _controller;
  bool _isCheckingLogin = true;
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await checkLoginStatus();
    if (isLoggedIn) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppWrapper()),
        (_) => false
      );
    } else {
      setState(() {
        _isCheckingLogin = false;
        _initializeWebView();
      });
    }
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            if (url.contains(
                'https://karmaclub.karmagroup.com/member/?ref=login-success')) {
              setState(() {
                _isLoggingIn = true;
              });

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', true);
              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AppWrapper()),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://karmaclub.karmagroup.com/member/'));
  }

  @override
  Widget build(BuildContext context) {
    const logo = "assets/images/logo.svg";

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          if (!_isCheckingLogin)
            SafeArea(
              child: WebViewWidget(controller: _controller),
            ),
          if (_isCheckingLogin || _isLoggingIn)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  logo,
                  width: 140,
                  fit: BoxFit.contain,
                  semanticsLabel: 'Karma Group Logo',
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
                const Center(child: LoadingComponent()),
              ],
            ),
        ],
      ),
    );
  }
}
