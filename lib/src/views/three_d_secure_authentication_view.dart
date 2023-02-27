import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThreeDSecureAuthenticationView extends StatefulWidget {
  final RedirectToUrl redirectToUrl;

  const ThreeDSecureAuthenticationView(this.redirectToUrl, {super.key});

  static Future<bool> buildView(BuildContext context,
      {required RedirectToUrl redirectToUrl}) async {
    return await Navigator.push<bool>(
          context,
          MaterialPageRoute<bool>(
            builder: (context) {
              return ThreeDSecureAuthenticationView(redirectToUrl);
            },
          ),
        ) ??
        false;
  }

  @override
  State<ThreeDSecureAuthenticationView> createState() =>
      _ThreeDSecureAuthenticationViewState();
}

class _ThreeDSecureAuthenticationViewState
    extends State<ThreeDSecureAuthenticationView> {
  late WebViewController _controller;
  final ValueNotifier<int> _processingNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            _processingNotifier.value = progress;
          },
          onNavigationRequest: (request) async {
            String? returnUrl = widget.redirectToUrl.returnUrl;
            if (returnUrl != null) {
              if (request.url.startsWith(widget.redirectToUrl.returnUrl!)) {
                Navigator.pop(context, true);
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectToUrl.url ?? ''));
  }

  @override
  void dispose() {
    _controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ValueListenableBuilder<int>(
        valueListenable: _processingNotifier,
        builder: (context, processing, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (processing != 100) _buildLoader(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoader() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: CupertinoActivityIndicator(
        radius: 15,
        color: colorScheme.primary,
      ),
    );
  }
}
