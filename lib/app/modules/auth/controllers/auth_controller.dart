import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/routes/app_pages.dart';


class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<User?> user = Rx<User?>(null);

  // void handleGoogleSignIn() async {
  //   try {
  //     final registerController = Get.put(RegisterController());
  //     final loginController = Get.put(LoginController());
  //     if (user.value == null) {
  //       GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  //       final UserCredential result = await auth.signInWithProvider(googleAuthProvider);
  //       user.value = result.user;
  //       if (user.value != null) {
  //         final String? email = result.user!.email;
  //         final String? displayName = result.user!.displayName;
  //         final String name = displayName ?? 'User'; // Fallback to 'User' if displayName is null
  //         final String password = result.user!.uid; // Using uid as password for consistency
  //         Log.e(user.value);
  //         try {
  //          bool status =  await loginController.loginUser(email: email!, password: password, isSocial: true);
  //          if(!status) {
  //            await registerController.registerUser(name: name, email: email!, password: password);
  //          }
  //
  //         } catch (loginError) {
  //           handleException(loginError);
  //         }
  //       }
  //     } else {
  //       // Sign out if already signed in
  //       await auth.signOut();
  //       user.value = null;
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //       print('Error');
  //     }
  //   }
  // }



  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      if (user.value != null) {
        Get.toNamed(Routes.MAINPAGE);
        if (kDebugMode) {
          print('Signed with Email Pass Successfully');
        }
      }
      update();
    } catch (error) {
      if (kDebugMode) {
        print("Error during sign-in: $error");
      }
    }
  }

  Future<void> registerUser(
      String email, String password, String userName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'email': email,
          'username': userName,
        },
      );

      Get.toNamed(Routes.LOGIN);
    } catch (error) {
      if (kDebugMode) {
        print("Error during signup: $error");
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    user.value = null;
    update();
  }

  // void showWelcomeDialog(User? user) {
  //   if (user != null) {
  //     Get.dialog(
  //       AlertDialog(
  //         content: AppTextStyle(
  //           text: 'Welcome! ${user.email}',
  //           fontWeight: FontWeight.w600,
  //           fontSize: 16.sp,
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    auth.authStateChanges().listen((event) {
      user.value = event;
    });
  }

  User? get users => user.value;

  /// For Facebook SignIn
  // //   void handleFacebook ()async{
  // //     final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
  // // // or FacebookAuth.i.login()
  // //     if (result.status == LoginStatus.success) {
  // //       // you are logged
  // //       final AccessToken accessToken = result.accessToken!;
  // //     } else {
  // //       print(result.status);
  // //       print(result.message);
  // //     }
  // //   }

  // Future<UserCredential> signInWithFacebook() async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //     if (loginResult.status == LoginStatus.success) {
  //       final AccessToken accessToken = loginResult.accessToken!;
  //       final OAuthCredential credential =
  //           FacebookAuthProvider.credential(accessToken.token);
  //       return await FirebaseAuth.instance.signInWithCredential(credential);
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'Facebook Login Failed',
  //         message: 'The Facebook login was not successful.',
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Handle Firebase authentication exceptions
  //     print('Firebase Auth Exception: ${e.message}');
  //     throw e; // rethrow the exception
  //   } catch (e) {
  //     // Handle other exceptions
  //     print('Other Exception: $e');
  //     throw e; // rethrow the exception
  //   }
  // }
}

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//             'you can reconfigure this by running the FlutterFire CLI again.',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//               'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//               'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//               'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }
//
//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyAHoZn60Cl1B2WKSLsAO_RoI4ZtiY9qzy8',
//     appId: '1:189080830346:android:b59907e3a8677488520873',
//     messagingSenderId: '189080830346',
//     projectId: 'fbauth-c0740',
//     storageBucket: 'fbauth-c0740.appspot.com',
//   );
//
//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyC11ZQePMu9OD5JajzI3LRbCHx3m1dP2To',
//     appId: '1:189080830346:ios:dc6e3c272f962b78520873',
//     messagingSenderId: '189080830346',
//     projectId: 'fbauth-c0740',
//     storageBucket: 'fbauth-c0740.appspot.com',
//     iosBundleId: 'com.example.fbsocial',
//   );
// }
