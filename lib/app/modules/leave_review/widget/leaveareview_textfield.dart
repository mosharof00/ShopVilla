import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/leave_review/controllers/leave_review_controller.dart';

class LeaveReviewTextField extends StatelessWidget {
  final TextEditingController textController;
  final int item;

  const LeaveReviewTextField(this.textController, this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    LeaveReviewController controller = Get.find();
    return SizedBox(
      height: 80.h,
      width: 310.w,
      child: Obx(() {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.transparent,
              border: Border.all(
                color: controller.isTextValid[item].value
                    ? Colors.grey // Regular color
                    : Colors.red,width: 2
              ), ),
          child: TextFormField(
            controller: textController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: null,
            expands: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              fillColor: const Color(0xFFe9ecef),
              filled: true,
              hintText: 'Leave a Review'.tr,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Color(0xFFadb5bd),
                  width: 1,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
