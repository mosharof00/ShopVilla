import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/log_printer.dart';

class LeaveReviewController extends GetxController {
  List<TextEditingController> reviewController = [];
  late MyOrder myOrder;
  List<RxDouble> ratings = [];
  List<Rxn<XFile?>> selectedImages = [];

  final apiService = ApiServices();

  List<RxBool> isRatingValid = [];
  List<RxBool> isTextValid = [];
  List<RxBool> isImageValid = [];

  @override
  void onInit() {
    final args = Get.arguments;
    myOrder = args['arg1'];

    for (var i = 0; i < myOrder.orderproducts!.length; i++) {
      reviewController.add(TextEditingController());
      ratings.add(0.0.obs);
      selectedImages.add(Rxn<XFile>());
    }

    isRatingValid = List.generate(myOrder.orderproducts!.length, (_) => true.obs);
    isTextValid = List.generate(myOrder.orderproducts!.length, (_) => true.obs);
    isImageValid = List.generate(myOrder.orderproducts!.length, (_) => true.obs);

    super.onInit();
  }

  @override
  void dispose() {
    for (var controller in reviewController) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> addReview({
    required int productID,
    required String text,
    required double rating,
    String? file, // Make the file nullable
  }) async {
    try {
      final addReview = await apiService.addReview(productID, text, rating, file);
      final message = addReview.message!;
      reviewController.clear();
      globalSnackBar(title: 'Review', message: message.toString());
    } catch (e) {
      Log.e(e.toString());
      handleException(e);
    }
  }


  Future<void> getProfileImageFromFile(int index) async {
    final selected = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImages[index].value = selected;
  }

  Future<void> getProfileImageFromCamera(int index) async {
    final selected = await ImagePicker().pickImage(source: ImageSource.camera);
    selectedImages[index].value = selected;
  }

  bool validateInputs(int index) {
    bool isValid = true;
    isRatingValid[index].value = ratings[index].value > 0;
    isTextValid[index].value = reviewController[index].text.isNotEmpty;
    // isImageValid[index].value = selectedImages[index].value != null;

    isValid = isRatingValid[index].value &&
        isTextValid[index].value ;
        // &&
        // isImageValid[index].value;

    return isValid;
  }
}
