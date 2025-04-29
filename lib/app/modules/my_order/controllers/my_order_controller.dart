import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/log_printer.dart';

class MyOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  RxInt selectedTabIndex = 0.obs; // Selected Tab index
  late TabController tabController;
  final RefreshController refreshControllerActive =
      RefreshController(initialRefresh: false); // Smart Refresh for Active
  final RefreshController refreshControllerComplete =
      RefreshController(initialRefresh: false); // Smart Refresh for Complete
  final RefreshController refreshControllerCancel =
      RefreshController(initialRefresh: false); // Smart Refresh for Cancel

  /// Order Status
  /// App End => Api Response
  static const String statusPending = 'Pending';
  static const String statusConfirmed = 'Confirmed';
  static const String statusOngoing = 'Ongoing';
  static const String statusDelivered = 'Delivered';
  static const String statusCancelled = 'Canceled';
  static const String statusRejected = 'Rejected';

  /// Stepper
  RxInt activeStep = 0.obs;
  // Method to get the step index based on order status
  int getActiveStep(String status) {
    switch (status) {
      case statusPending:
        return 1;
      case statusConfirmed:
        return 2;
      case statusOngoing:
        return 3;
      case statusDelivered:
        return 4;
      default:
        return 0;
    }
  }

  //Pending,Confirmed,Ongoing,Delivered,Canceled,Returned,Rejected
  // Method to get the description of the order status based on the active step
  String statusDesc(int activeStep) {
    String status = '';
    switch (activeStep) {
      case 1:
        status = 'Pending'.tr;
        break;
      case 2:
        status = 'Confirmed'.tr;
        break;
      case 3:
        status = 'Ongoing'.tr;
        break;
      case 4:
        status = 'Delivered'.tr;
        break;
      default:
        status = 'Arrived'.tr;
        break;
    }
    return status;
  }


  ///  for pagination
  final currentPage = 1.obs;
  final currentActivePage = 0.obs;
  final isEndPage = false.obs;
  final isEndActivePage = false.obs;
  final isLoadingUserOrderList = true.obs;
  final isLoadingActiveOrderList = true.obs;

  /// Api Service
  final apiService = ApiServices();

  /// User Order List
  final userOrderList = UserOrderListGetModel().obs;
  final orderList = <MyOrder>[].obs;
  final orderListActive = <MyOrder>[].obs;
  final activeOrderList = <MyOrder>[].obs;
  final completeOrderList = <MyOrder>[].obs;
  final cancelOrderList = <MyOrder>[].obs;

  // Fetch the list of user orders (pagination support)
  Future<void> getUserOrderList({bool isRefresh = false}) async {
    if (isRefresh) {
      currentActivePage.value = 0;
      completeOrderList.value = [];
      cancelOrderList.value = [];
    }
    try {
      final list =
          await apiService.userOrderList(page: currentActivePage.value + 1);
      isRefresh
          ? refreshControllerComplete.refreshCompleted()
          : refreshControllerComplete.loadComplete();
      isLoadingUserOrderList.value = false;
      if (list.data!.data!.isEmpty) {
        isEndPage.value = true;
      }
      currentPage.value = list.data!.currentPage!;
      isRefresh
          ? orderList.value = list.data!.data!
          : orderList.addAll(list.data!.data!);
      completeOrderList.value = orderList
          .where((order) => [statusDelivered].contains(order.status))
          .toList();
      cancelOrderList.value = orderList
          .where((order) => [statusCancelled, statusRejected].contains(order.status))
          .toList();
    } catch (e) {
      isLoadingUserOrderList.value = false;
      handleException(e);
    }
  }

  // Fetch the list of active orders (pagination support)
  Future<void> getActiveOrderList({bool isRefresh = false}) async {
    if (isRefresh) {
      currentActivePage.value = 0;
    }
    try {
      final list = await apiService.userActiveOrderList(
          page: currentActivePage.value + 1);
      isRefresh
          ? refreshControllerActive.refreshCompleted()
          : refreshControllerActive.loadComplete();
      isLoadingActiveOrderList.value = false;
      if (list.data!.data!.isEmpty) {
        isEndActivePage.value = true;
      }
      currentActivePage.value = list.data!.currentPage!;
      isRefresh
          ? orderListActive.value = list.data!.data!
          : orderListActive.addAll(list.data!.data!);
      activeOrderList.value = orderListActive;
    } catch (e) {
      isLoadingActiveOrderList.value = false;
      handleException(e);
    }
  }

  // Cancel an order by its invoice ID
  Future<void> cancelOrder(
      {required String invoiceID, required int index}) async {
    try {
      final cancelOrder = await apiService.userOrderCancel(invoiceID);
      Get.snackbar('Cancel Order', cancelOrder.message!);
      MyOrder myOrder = activeOrderList[index];
      isLoadingUserOrderList.value = false;
      myOrder = myOrder.copyWith(
        status: 'Canceled',
      );
      activeOrderList.removeAt(index);
      activeOrderList.insert(index, myOrder);
      cancelOrderList.insert(0, myOrder);
    } catch (e) {
      isLoadingUserOrderList.value = false;
      Log.i('Handle Exception');
      handleException(e);
    }
  }

  // Refresh Active orders
  Future<void> refreshActiveOrders() async {
    isEndActivePage.value = false;
    await getActiveOrderList();
  }
  // Refresh Completed orders
  Future<void> refreshUserCompleteOrders() async {
    isEndPage.value = false;
    await getUserOrderList();
  }
  // Refresh Cancel Orders
  Future<void> refreshUserCancelOrders() async {
    isEndPage.value = false;
    await getUserOrderList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    getActiveOrderList();
    getUserOrderList();
  }

  // Update the selected tab and animate the tab controller
  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
    update();
  }

  @override
  void dispose() {
    refreshControllerActive.dispose();
    refreshControllerComplete.dispose();
    refreshControllerCancel.dispose();
    tabController.dispose();
    super.dispose();
  }

  // Reason for canceling an order
  // For Cancel Order
  RxInt selectedReasonOptionIndex = 0.obs;
  final List<String> cancelReasonsList = [
    'Want to place a New order with more/different items.'.tr,
    'Delivery item is too long'.tr,
    'Duplicate order'.tr,
    'Shopping const is too high'.tr,
    'Change of delivery address'.tr,
    'Forgot to use voucher/promos issue'.tr,
  ];
}
