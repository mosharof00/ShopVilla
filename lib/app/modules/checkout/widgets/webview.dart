import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import 'package:shop_villa/helper/log_printer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/checkout_controller.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;

  const PaymentWebViewScreen({super.key, required this.url});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  final checkoutController = Get.put(CheckoutController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            checkoutController.isLoading.value = true;
            checkoutController.showLoadingDialog();
          },
          onPageFinished: (String url) async {
            checkoutController.isLoading.value = false;
            checkoutController.closeLoadingDialogIfOpen();
            // Handle payment success/failure based on URL
            if (url.contains("api/success") ||
                url.contains('/api/stripe/success') ||
                url.contains('status=success') ||
                url.contains('status=success') ||
                url.contains('api/razorpay/success')||
                url.contains("api/paypal/success")
            ) {
              Get.back(); // Dismiss the WebView
              await HelperUtils.navigateToOrder(); // Navigate to Order Page
              Get.snackbar('Payment Success', 'Thank you!.');
            } else if (url.contains("api/fail")) {
              Get.back(); // Dismiss the WebView
              HelperUtils.navigateToOrder(); // Navigate to Order Page
              Get.snackbar('Payment failed', 'Please try again.');
            }
          },
          onWebResourceError: (WebResourceError error) {
            checkoutController.isLoading.value = false;
            // Close the loading dialog
            Get.snackbar(
                'Error', 'Failed to load the payment page. Please try again.');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Prevent navigation to disallowed URLs
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          surfaceTintColor: ColorName.bgColor,
          backgroundColor: ColorName.bgColor,
          title: appbarTitle(text: 'Payment Gateway'),
          centerTitle: true,
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
