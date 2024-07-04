import 'package:fisimate_flutter_app/app/modules/login/controllers/login_with_google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWithGoogleView extends GetView<LoginWithGoogleController> {
  const LoginWithGoogleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginWithGoogleController>();
    final webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(controller.googleAuthUrl));
    return Scaffold(
      body: WebViewWidget(controller: webviewController),
    );
  }
}
