import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView3dvrScreen extends StatefulWidget {
  final String url;

  const WebView3dvrScreen({super.key, required this.url});

  @override
  State<WebView3dvrScreen> createState() => _WebView3dvrScreenState();
}

class _WebView3dvrScreenState extends State<WebView3dvrScreen> with AutomaticKeepAliveClientMixin{
   InAppWebViewController? webViewController;
   String currentUrl = "";

   @override
  void initState() {
    super.initState();
    currentUrl = widget.url;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() async {
    try {
      await webViewController?.stopLoading();
      await webViewController?.clearHistory();
      await CookieManager.instance().deleteAllCookies();
      await WebStorageManager.instance().deleteAllData();
    } catch (e) {
      debugPrint("WebView cleanup error: $e");
    }
    webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(title: Text("WebView")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(currentUrl),
        ),
          initialSettings:InAppWebViewSettings(
            javaScriptEnabled: true,
            useHybridComposition: true,
            cacheEnabled: false,
            clearCache: true,
            allowsInlineMediaPlayback: true,
            mediaPlaybackRequiresUserGesture: false,
            transparentBackground: false,
          ),
        // initialOptions: InAppWebViewGroupOptions(
        //   crossPlatform: InAppWebViewOptions(
        //     javaScriptEnabled: true,
        //     useOnDownloadStart: true,
        //     mediaPlaybackRequiresUserGesture: false,
        //     transparentBackground: true,
        //   ),
        //   android: AndroidInAppWebViewOptions(
        //     useHybridComposition: true,
        //   ),
        //   iosCopy: IOSInAppWebViewOptions(
        //     allowsInlineMediaPlayback: true,
        //   ),
        // ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onRenderProcessGone: (controller, detail) async {
          debugPrint("WebView crashed — reloading...");
          await controller.loadUrl(urlRequest: URLRequest(url: WebUri(currentUrl)));
        },
      ),
    );
  }
}
