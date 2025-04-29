// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:shop_villa/global/sizedbox_extension.dart';
// import '../../../../gen/assets.gen.dart';
// import '../../../../gen/colors.gen.dart';
// import '../../../../global/app_text_style.dart';
// import '../../../../global/global_button.dart';
// import '../../../../global/signin_option.dart';
// import '../../../routes/app_pages.dart';
// import '../../login/views/login_ui_helper.dart';
// import '../controllers/auth_controller.dart';
//
// class AuthView extends GetView<AuthController> {
//   const AuthView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             70.height,
//             Align(
//               alignment: Alignment.center,
//               child: SvgPicture.asset(
//                 Assets.images.logo,
//                 colorFilter: const ColorFilter.mode(
//                     ColorName.primaryColor, BlendMode.srcIn),
//               ),
//             ),
//             50.height,
//             AppTextStyle(
//               text: 'Let\'s Get Started!',
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w800,
//             ),
//             5.height,
//             AppTextStyle(
//               text: "Let's Dive into Your Account",
//               color: Colors.grey,
//               fontSize: 13.sp,
//             ),
//             40.height,
//             signInOption(
//               onTap: controller.signInWithGoogle,
//               icon: Assets.icons.googleIcon,
//               text: 'Continue with Google',
//             ),
//             30.height,
//             globalButton(
//               onTap: () {
//                 Get.toNamed(Routes.REGISTER);
//               },
//               text: "Register",
//             ),
//             20.height,
//             disableButton(
//                 onTap: () {
//                   Get.toNamed(Routes.LOGIN);
//                 },
//                 text: 'Login'),
//             const Spacer(),
//             const AppTextStyle(text: "Privacy Policy   .   Terms of Service"),
//             10.height
//           ],
//         ),
//       ),
//     );
//   }
// }
