import 'package:flutter/material.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_wrapper.dart';

class AppLauncher extends StatefulWidget {
  const AppLauncher({super.key});

  @override
  State<AppLauncher> createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    isLoggedIn = await checkLoginStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print("======AppLauncher=====");
    return const AppWrapper();
    // return isLoggedIn ? const AppWrapper() : const LoginScreen();
  }
}
