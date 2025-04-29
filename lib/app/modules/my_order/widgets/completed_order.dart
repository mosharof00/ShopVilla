import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_villa/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:shop_villa/app/modules/my_order/widgets/product_labels.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../../../../global/global_button.dart';
import '../../../../global/loading_animation_widget.dart';
import '../../../../global/parse_dateAndTime.dart';
import '../../../models/order place/user_orderlist_post_model.dart';
import '../../../routes/app_pages.dart';

class CompleteOrder extends GetView<MyOrderController> {
  const CompleteOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoadingUserOrderList.value
        ? loadingAnimationWidget()
        : controller.completeOrderList.isEmpty
        ? _buildEmptyState()
        : _buildOrderList());
  }

  Widget _buildEmptyState() {
    return ListView(
      // Wrapping in a ListView to ensure RefreshIndicator can be triggered
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              60.height,
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: SvgPicture.asset(
                  Assets.images.noorder,
                  height: 250.h,
                  width: Get.width,
                ),
              ),
              10.height,
              AppTextStyle(
                text: "No Order Placed!",
                color: ColorName.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderList() {
    return Obx(() {
      return SmartRefresher(
          controller: controller.refreshControllerComplete,
          enablePullUp: true,
          onRefresh: () async {
            try{
              await controller.getUserOrderList(isRefresh: true);
            }catch(e){
              controller.refreshControllerComplete.refreshFailed();
            }
          },
          onLoading: () async {
            await controller.getUserOrderList();
          },
          header: const WaterDropHeader(
            waterDropColor: ColorName.primaryColor,
            idleIcon: Icon(Icons.autorenew_rounded, color: ColorName.white, size: 20,),
          ),
          footer: CustomFooter(
            builder: (BuildContext? context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("Pull up load");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("release to load more");
              } else {
                body = const Text("No more Order");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          child: ListView.builder(
            itemCount: controller.completeOrderList.length,
            itemBuilder: (context, index) {
              final myOrder = controller.completeOrderList[index];
              return GestureDetector(
                onTap: (){
                  Get.toNamed(
                    Routes.ORDER_DETAILS,
                    arguments: {'arg1': myOrder},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(15.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: ColorName.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildOrderHeader(myOrder),
                            5.height,
                            Divider(color: Colors.pink.shade100),
                            10.height,
                            _buildOrderDetails(myOrder),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ));
    });
  }

  Widget _buildOrderHeader(MyOrder myOrder) {
    return Row(
      children: [
        const Icon(Icons.shopping_bag, color: Colors.green),
        10.width,
        AppTextStyle(
          text: DateTimeUtils.parseDate(myOrder.orderDate!.toString()),
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        const Spacer(),
        ProductLabels(text: myOrder.status!),
      ],
    );
  }

  Widget _buildOrderDetails(MyOrder myOrder) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImages(myOrder),
        5.width,
        _buildOrderInfo(myOrder),
      ],
    );
  }

  Widget _buildProductImages(MyOrder myOrder) {
    return Stack(
      children: [
        SizedBox(
          height: 190.h,
          width: 175.w,
          child: Stack(
            children: List.generate(myOrder.orderproducts!.length > 3 ? 3 : myOrder.orderproducts!.length, (index) {
              return _buildProductImage(myOrder, index);
            }),
          ),
        ),
        Positioned(
          top: 0.h,
          left: 0.w,
          child: Container(
            height: 20.h,
            width: 20.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorName.primaryColor,
            ),
            child: Center(
              child: AppTextStyle(
                text: myOrder.orderproducts!.length.toString(),
                color: ColorName.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.h,
          right: myOrder.orderproducts!.length > 3 ? 8.w : 20.w,
          child: Center(
            child: ProductLabels(
              width: 50,
              text: myOrder.total != myOrder.paidAmount ? 'Due' : 'Paid'
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(MyOrder myOrder, int index) {
    if (index == 0) {
      // First image is the background image
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: ColorName.white)
        ),
        child: cachedImageHelper(
          imgurl: myOrder.orderproducts![index].productvariation!.image!,
          imgHeight: 180.h,
          imgWidth: 158.w,
        ),
      );
    } else {
      // Other images are overlayed on top of the background image
      return Positioned(
        top: 0.h,
        left: index * 5.h,
        // Increase left position by 5.h for each image
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: ColorName.white)
          ),
          child: cachedImageHelper(
            imgurl: myOrder.orderproducts![index].productvariation!.image!,
            imgHeight: 180.h,
            imgWidth: 158.w,
          ),
        ),
      );
    }
  }

  Widget _buildOrderInfo(MyOrder myOrder) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'InvoiceID: ',
            maxLines: 3,
            fontSize: 13.sp,
          ),
          AppTextStyleOverFlow(
            text: myOrder.invoiceId.toString(),
            maxLines: 1,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          5.height,
          AppTextStyle(
            text: 'City : ${myOrder.city}',
            fontSize: 13.sp,
          ),
          5.height,
          AppTextStyleOverFlow(
            text: 'Address : ${myOrder.address}',
            maxLines: 1,
            fontSize: 13.sp,
          ),
          5.height,
          AppTextStyle(
            text: 'Phone : ${myOrder.phone}',
            fontSize: 13.sp,
          ),
          5.height,
          AppTextStyle(
            text: '${myOrder.total.toString()} Tk',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          10.height,
          Align(
            alignment: Alignment.centerRight,
            child: globalButton(
                onTap: () {
                  Get.toNamed(
                    Routes.LEAVE_REVIEW,
                    arguments: {'arg1': myOrder},
                  );
                },
                text: 'Leave a Review',
                width: 110.w,
                blurRadius: 1,
                shadowColor: Colors.transparent,
                fontSize: 11.sp,
                height: 30),
          ),

        ],
      ),
    );
  }
}
