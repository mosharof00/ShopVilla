import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:shop_villa/app/modules/my_order/order_details/widgets/recipt.dart';
import 'package:shop_villa/global/global_button.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/parse_dateAndTime.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/cached_network_image_builder.dart';
import '../../../../../global/divider.dart';
import '../../../../../global/methods/get_currency.dart';
import '../../../profile/paymentMethods/controllers/payment_methods_controller.dart';
import '../../widgets/product_labels.dart';
import '../controllers/order_details_controller.dart';
import 'fileHandle.dart';
import 'helper_container.dart';
import 'package:pdf/widgets.dart' as pw;
import 'orderDetailsContainer.dart';

class ViewOrderDetails extends GetView<OrderDetailsController> {
  const ViewOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyOrderController());
    return Obx(() {
      if(controller.profileDetails.value.data == null){
        return Center(child: loadingAnimationWidget(),);
      }
      controller.selectedTabIndex.value;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              10.height,
              orderDetailsContainer(
                icon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                text: 'User Information',
                leading: circularImage(
                  imgUrl: controller.myOrder.user!.image!,
                  radius: 22.r,
                ),
                firstTitleTextKey: 'Name :   ',
                firstTitleTextValue: controller.myOrder.name.toString(),
                secondTitleTextKey: 'Phone :   ',
                secondTitleTextValue: controller.myOrder.phone.toString(),
                subtitleTextKey: 'Address : ',
                subtitleTextValue: controller.myOrder.address.toString(),
                isTrailing: false,
              ),
              10.height,
              orderDetailsContainer(
                icon: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.green,
                ),
                text: 'Delivery Address',
                leading: const Icon(
                  Icons.location_on_sharp,
                  color: Colors.white,
                ),
                firstTitleTextKey: 'City :       ',
                firstTitleTextValue: controller.myOrder.city.toString(),
                secondTitleTextKey: 'District :  ',
                secondTitleTextValue: controller.myOrder.district.toString(),
                subtitleTextKey: 'Address : ',
                subtitleTextValue: controller.myOrder.address.toString(),
                isTrailing: false,
              ),
              15.height,
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: ColorName.white,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      10.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          5.width,
                          const Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.green,
                          ),
                          10.width,
                          AppTextStyle(
                            text:
                            '${'Your Order'.tr} (${controller.myOrder.orderproducts!.length})',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                          const Spacer(),
                          ProductLabels(text: controller.myOrder.status!)
                        ],
                      ),
                      10.height,
                      customDivider(),
                      5.height,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.myOrder.orderproducts!.length,
                        itemBuilder: (context, index) {
                          final Orderproduct orderProduct =
                          controller.myOrder.orderproducts![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  cachedImageHelper(
                                      imgurl:
                                      orderProduct.productvariation!.image!,
                                      imgHeight: 115.h,
                                      imgWidth: 0.3.sw),
                                  10.width,
                                  SizedBox(
                                    width: 0.4.sw,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        AppTextStyleOverFlow(
                                          text: orderProduct.productName!,
                                          maxLines: 2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                        5.height,
                                        AppTextStyle(
                                          text:
                                          '${'Size'.tr} : ${orderProduct.size}',
                                          fontSize: 12.sp,
                                        ),
                                        5.width,
                                        AppTextStyle(
                                          text:
                                          '${'Color'.tr} : ${orderProduct.color}',
                                          fontSize: 12.sp,
                                        ),
                                        5.height,
                                        AppTextStyle(
                                          text: '${'Quantity'.tr} : ${ orderProduct.qty!.toString()}',
                                          fontSize: 12.sp,
                                        ),
                                        5.height,
                                        Row(
                                          children: [
                                            AppTextStyle(
                                              text: '${'Price'.tr} : ',
                                              fontSize: 12.sp,
                                            ),
                                            AppTextStyle(
                                              text:
                                              GetCurrency.concatWithCurrency(
                                                orderProduct.price.toString(),
                                                GetCurrency.currencySymbol,
                                              ),
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              15.height,
              Obx(() {
                controller.getPaymentMethod(
                    controller.myOrder.paymentMethod.toString());
                return helperContainer(
                  showIcon: false,
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.creditCardOutline,
                    color: Colors.green,
                  ),
                  text: 'Payment Methods',
                  leading: circularImage(
                      imgUrl: controller.image.value,
                      radius: 22.r,
                      imgRadius: 50.r),
                  titleText: controller.gateway.value,
                  subtitleText: '',
                  isTrailing: true,
                  trailWidget: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    height: 25.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: controller.myOrder.total != controller.myOrder.paidAmount
                          ? ColorName.crimsonRed
                          : ColorName.green,
                    ),
                    child: InkWell(
                      onTap: controller.myOrder.total != controller.myOrder.paidAmount
                          ? () {
                        final paymentController =
                        Get.put(PaymentMethodsController());
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: ColorName.gray70,
                            elevation: 3,
                            title: AppTextStyle(
                              text: 'Make Payment',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                labels(
                                    text: '${'Invoice Number'.tr} : ',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                                5.height,
                                labels(
                                    text: controller.myOrder.invoiceId!
                                        .toString(),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorName.primaryColor),
                                10.height,
                                labels(
                                    text: '${'Payment Methods'.tr} : ',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                                5.height,
                                Obx(() {
                                  return DropdownButton<String>(
                                    value: paymentController
                                        .selectedPaymentType.value,
                                    items: paymentController
                                        .paymentTypeList
                                        .map((paymentType) {
                                      return DropdownMenuItem<String>(
                                        value: paymentType.value,
                                        child: Text(
                                          paymentType.status!,
                                          style: const TextStyle(
                                              color: ColorName.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (status) {
                                      paymentController
                                          .selectedPaymentType
                                          .value = status!;
                                    },
                                  );
                                }),
                                10.height,
                                Row(
                                  children: [
                                    globalButton(
                                        onTap: () {
                                          if (Get.isDialogOpen!) {
                                            Get.back();
                                          }
                                        },
                                        width: Get.width / 3.2,
                                        height: 30.h,
                                        text: 'Cancel',
                                        fontSize: 13.sp,
                                        gradient: const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Colors.white
                                            ]),
                                        shadowColor: ColorName.white,
                                        fontColor: ColorName.black),
                                    10.width,
                                    globalButton(
                                        onTap: () {
                                          controller.reOrder(
                                            invoiceID: controller
                                                .myOrder.invoiceId
                                                .toString(),
                                            paymentMethod:
                                            paymentController
                                                .selectedPaymentType
                                                .value
                                                .toString(),
                                          );
                                        },
                                        width: Get.width / 3.2,
                                        height: 30.h,
                                        text: 'Confirm',
                                        fontSize: 13.sp,
                                        color: ColorName.white,
                                        fontColor: ColorName.white),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                          : null,
                      child: Center(
                        child: labels(
                          text: controller.myOrder.total != controller.myOrder.paidAmount
                              ? 'Pay'
                              : 'Paid',
                          color: ColorName.white,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              controller.myOrder.couriers == null
                  ? 0.height
                  : Column(
                children: [
                  15.height,
                  helperContainer(
                    icon: Icon(
                      MdiIcons.truckDelivery,
                      color: Colors.green,
                    ),
                    text: 'Courier',
                    leading: circularImage(
                        imgUrl: controller.myOrder.couriers!.image!,
                        radius: 22.r,
                        imgRadius: 50.r),
                    titleText: controller.myOrder.couriers!.courierName!,
                    subtitleText: controller.myOrder.hubName!,
                    isTrailing: false,
                  ),
                ],
              ),
              15.height,
              helperContainer(
                icon: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.green,
                ),
                text: 'Discount',
                leading: Icon(
                  MdiIcons.brightnessPercent,
                  color: Colors.green,
                ),
                titleText: controller.myOrder.coupon == null
                    ? 'No Promos Selected'.tr
                    : controller.myOrder.coupon.toString(),
                subtitleText: controller.myOrder.coupon == null
                    ? ''
                    : controller.myOrder.coupon.toString(),
                isTrailing: false,
              ),
              15.height,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        controller.profileDetails.value.data!.image == null
                            ? Icon(
                          MdiIcons.fileDocumentOutline,
                          color: Colors.green,
                        )
                            : cachedImageHelper(
                            imgurl: controller
                                .profileDetails.value.data!.image!,
                            imgWidth: 25.w,
                            imgHeight: 25.h,
                            radius: 50.r),
                        10.width,
                        AppTextStyle(
                          text: 'Billing Address',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    customDivider(),
                    10.height,
                    summaryOptionsRow(
                      leadingText: 'Name',
                      thrillingText:
                      controller.profileDetails.value.data!.name!,
                      thrillingTextColor: ColorName.gray410,
                    ),
                    5.height,
                    controller.profileDetails.value.data!.email == null
                        ? const SizedBox.shrink()
                        : summaryOptionsRow(
                      leadingText: 'Email',
                      thrillingText: controller
                          .profileDetails.value.data!.email!,
                      thrillingTextColor: ColorName.gray410,

                    ),
                    5.height,
                    controller.profileDetails.value.data!.phone == null
                        ? const SizedBox.shrink()
                        : summaryOptionsRow(
                      leadingText: 'Phone',
                      thrillingText: controller
                          .profileDetails.value.data!.phone!,
                      thrillingTextColor: ColorName.gray410,
                    ),
                  ],
                ),
              ),              15.height,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.r),
                // height:
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.fileDocumentOutline,
                          color: Colors.green,
                        ),
                        10.width,
                        AppTextStyle(
                          text: 'Review Summary',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    customDivider(),
                    10.height,
                    summaryOptionsRow(
                      leadingText:
                      '${'Subtotal'.tr} (${controller.myOrder.orderproducts!.length} items)',
                      thrillingText:
                      GetCurrency.concatWithCurrency(controller.myOrder.subTotal.toString(), GetCurrency.currencySymbol),
                    ),
                    5.height,
                    summaryOptionsRow(
                      leadingText: 'Shipping Charge',
                      thrillingText:
                      '+ ${GetCurrency.concatWithCurrency(controller.myOrder.shippingCharge.toString(), GetCurrency.currencySymbol)}',
                    ),
                    5.height,
                    summaryOptionsRow(
                      leadingText: 'Discount',
                      thrillingText:
                      '- ${GetCurrency.concatWithCurrency(controller.myOrder.discount.toString(), GetCurrency.currencySymbol)}',
                    ),
                    5.height,
                    controller.myOrder.advancePaymentStatus == '1'
                        ? summaryOptionsRow(
                        leadingText: 'Advance Payment',
                        thrillingText:
                        '- ${GetCurrency.concatWithCurrency(controller.myOrder.advancePaymentAmount.toString().split('.')[0], GetCurrency.currencySymbol)}')
                        : const SizedBox.shrink(),
                    5.height,
                    summaryOptionsRow(
                      leadingText: 'Tax',
                      thrillingText:
                      GetCurrency.concatWithCurrency(controller.myOrder.tax.toString(), GetCurrency.currencySymbol),
                    ),
                    5.height,
                    summaryOptionsRow(
                      leadingText: 'Vat',
                      thrillingText:
                      GetCurrency.concatWithCurrency(controller.myOrder.vat.toString(), GetCurrency.currencySymbol),
                    ),
                    5.height,
                    customDivider(),
                    5.height,
                    Obx(() {
                      double dueAmount = controller.myOrder.total!.toDouble() - controller.myOrder.paidAmount!.toDouble();
                      return summaryOptionsRow(
                        leadingText: 'Due',
                        fontSizeLeadingText: 15.sp,
                        fontWeightLeadingText: FontWeight.w500,
                        thrillingText:
                        GetCurrency.concatWithCurrency(dueAmount.toString(), GetCurrency.currencySymbol), // Convert to string
                        fontSizeThrillingText: 15.sp,
                        fontWeightThrillingText: FontWeight.w600,
                        thrillingTextColor: ColorName.gray410,
                      );
                    }),
                    customDivider(),
                    5.height,
                    Obx(() {
                      return summaryOptionsRow(
                        leadingText: 'Total',
                        fontSizeLeadingText: 15.sp,
                        fontWeightLeadingText: FontWeight.w500,
                        thrillingText:
                        GetCurrency.concatWithCurrency(controller.myOrder.total.toString().split('.')[0], GetCurrency.currencySymbol),
                        fontSizeThrillingText: 18.sp,
                        fontWeightThrillingText: FontWeight.w600,
                      );
                    }),
                  ],
                ),
              ),
              15.height,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.r),
                // height:
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.informationBoxOutline,
                          color: Colors.green,
                        ),
                        10.width,
                        AppTextStyle(
                          text: 'Information Details',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    customDivider(),
                    10.height,
                    summaryOptionsRow(
                      leadingText: 'Purchase Date',
                      thrillingText: DateTimeUtils.parseDate(
                        controller.myOrder.createdAt!.toString(),
                      ),
                    ),
                    5.height,
                    // summaryOptionsRow(
                    //     leadingText: 'Purchase Hour',
                    //     thrillingText: orderController.formatTime(controller
                    //         .myOrder.createdAt!.toString())),
                    summaryOptionsRow(
                        leadingText: 'Purchase Time',
                        thrillingText: DateTimeUtils.parseTime(
                            controller.myOrder.createdAt!.toString())),
                    5.height,
                    Obx(() {
                      return summaryOptionsRow(
                          leadingText: 'Invoice Number',
                          thrillingText:
                          controller.myOrder.invoiceId.toString(),
                          thrillingIcon: InkWell(
                            onTap: () async {
                              if (controller.isSelect.value) {
                                controller.isSelect.value = false;
                              } else {
                                controller.isSelect.value = true;
                                final String textToCopy =
                                controller.myOrder.invoiceId.toString();
                                if (textToCopy.isNotEmpty) {
                                  try {
                                    await Clipboard.setData(
                                        ClipboardData(text: textToCopy));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const AppTextStyle(
                                            text: 'Copied to Clipboard!'),
                                        backgroundColor:
                                        ColorName.white.withOpacity(0.5),
                                        duration:
                                        const Duration(microseconds: 200),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Failed to copy to clipboard.')),
                                    );
                                  }
                                }
                              }
                            },
                            child: Icon(
                              controller.isSelect.value
                                  ? Icons.check
                                  : Icons.copy,
                              size: 18,
                            ),
                          ));
                    }),
                  ],
                ),
              ),
              30.height,
              globalButton(
                onTap: () async {
                  // Generate PDF file
                  final pdfFile = await PdfInvoiceApiFromApi.generate(
                    controller.myOrder,
                    PdfColors.black,
                    pw.Font.courier(),
                  );

                  // Open the PDF file
                  FileHandleApi.openFile(pdfFile);
                },
                text: "Generate Invoice",
              )
            ],
          ),
        ),
      );
    });
  }
}
