import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/q&a/q&aUserQusPostModel.dart';
import 'package:shop_villa/app/modules/products/productDetails/controllers/product_details_controller.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/helper/exception_handle.dart';

class QusAndAnsController extends GetxController {
  TextEditingController textEditingController = TextEditingController(); // Text Editing Controller
  /// Api Service
  final apiService = Get.put(ApiServices());


  /// Q & A Post Question User
  final userQus = UserQus().obs; // Creating an instance of UserQues
  Future<void> qaUserQus({required String userID, required String productID, required String qus}) async {
    try{
      final postQus = await apiService.qaUserQus(userID, productID, qus); // Post Question
      if(postQus.status!){
          userQus.value = postQus.data!;
          Get.find<ProductDetailsController>().qaList(int.parse(productID));
          dispose();
      } else {
        debugPrint(postQus.status!.toString());
      }
    }catch(e){
      handleException(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.clear();
  }
}
