import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../global/app_text_style.dart';

class SliderBannerText extends StatelessWidget {
  const SliderBannerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: 'Nike\'s Offer upto 50%',
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              // AppTextStyle(text: 'End\'s In', fontWeight: FontWeight.w600,fontSize: 16.sp,),
            ],
          ),
        ),
      ],
    );
  }
}
