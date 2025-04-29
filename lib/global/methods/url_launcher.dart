import 'package:shop_villa/global/global_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> url(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      globalSnackBar(
          title: 'We are sorry!',
          message: 'Something Went wrong. Please try again letter');
      throw 'Could not launch $url';
    }
  }
}
