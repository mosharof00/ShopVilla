import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

class EndsIn extends StatelessWidget {
  const EndsIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: 'End\'s In',
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorName.black,
          ),
          child: TimerCountdown(
            spacerWidth: 3,
            timeTextStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
              color: ColorName.yellow,
            ),
            colonsTextStyle: TextStyle(
              color: ColorName.yellowOcher,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            enableDescriptions: false,
            format: CountDownTimerFormat
                .hoursMinutesSeconds,
            endTime: DateTime.now().add(
              const Duration(
                days: 1,
                hours: 00,
                minutes: 01,
                seconds: 05,
              ),
            ),
            onEnd: () {
              if (kDebugMode) {
                print("Timer finished");
              }
            },
          ),
        ),
      ],
    );
  }
}
