import 'package:get/get.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';

class GetCurrency {
  static String get currencySymbol {
    final currencyService = Get.put(HomeController());
    return currencyService.currency.value.symbol ?? '';
  }
  static String get currencyName {
    final currencyService = Get.put(HomeController());
    return currencyService.currency.value.name ?? '';
  }
  static String get currencyCode {
    final currencyService = Get.put(HomeController());
    return currencyService.currency.value.name ?? '';
  }
  static String concatWithCurrency(String amount, String currencySymbol) {
    final currencyService = Get.put(HomeController());
    return currencyService.currency.value.symbolPosition?.toLowerCase() == 'right'
        ? '$amount$currencySymbol'
        : '$currencySymbol$amount';
  }
}
