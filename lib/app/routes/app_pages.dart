import 'package:get/get.dart';

import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/chats/bindings/chats_binding.dart';
import '../modules/chats/views/chats_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/choose_delivery/bindings/choose_delivery_binding.dart';
import '../modules/choose_delivery/views/choose_delivery_view.dart';
import '../modules/choose_delivery_address/add_delivery_address/bindings/add_delivery_address_binding.dart';
import '../modules/choose_delivery_address/add_delivery_address/views/add_delivery_address_view.dart';
import '../modules/choose_delivery_address/bindings/choose_delivery_address_binding.dart';
import '../modules/choose_delivery_address/views/choose_delivery_address_view.dart';
import '../modules/flashSales/bindings/flash_sales_binding.dart';
import '../modules/flashSales/views/flash_sales_view.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/changePassword/bindings/change_password_binding.dart';
import '../modules/forgotPassword/changePassword/views/change_password_view.dart';
import '../modules/forgotPassword/verifyOTP/bindings/verify_o_t_p_binding.dart';
import '../modules/forgotPassword/verifyOTP/views/verify_o_t_p_view.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/leave_review/bindings/leave_review_binding.dart';
import '../modules/leave_review/views/leave_review_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mainpage/bindings/mainpage_binding.dart';
import '../modules/mainpage/views/mainpage_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/my_order/bindings/my_order_binding.dart';
import '../modules/my_order/order_details/bindings/order_details_binding.dart';
import '../modules/my_order/order_details/views/order_details_view.dart';
import '../modules/my_order/views/my_order_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboard_page/bindings/onboard_page_binding.dart';
import '../modules/onboard_page/views/onboard_page_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/productDetails/bindings/product_details_binding.dart';
import '../modules/products/productDetails/views/product_details_view.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/accountAndSecurity/bindings/account_and_security_binding.dart';
import '../modules/profile/accountAndSecurity/views/account_and_security_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/editProfile/bindings/edit_profile_binding.dart';
import '../modules/profile/editProfile/views/edit_profile_view.dart';
import '../modules/profile/helpAndSupport/bindings/help_and_support_binding.dart';
import '../modules/profile/helpAndSupport/views/help_and_support_view.dart';
import '../modules/profile/notifications/bindings/notifications_binding.dart';
import '../modules/profile/notifications/views/notifications_view.dart';
import '../modules/profile/paymentMethods/addNewPayment/bindings/add_new_payment_binding.dart';
import '../modules/profile/paymentMethods/addNewPayment/views/add_new_payment_view.dart';
import '../modules/profile/paymentMethods/bindings/payment_methods_binding.dart';
import '../modules/profile/paymentMethods/views/payment_methods_view.dart';
import '../modules/profile/settings/bindings/settings_binding.dart';
import '../modules/profile/settings/views/settings_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/promos_vouchers/bindings/promos_vouchers_binding.dart';
import '../modules/promos_vouchers/views/promos_vouchers_view.dart';
import '../modules/qus_and_ans/bindings/qus_and_ans_binding.dart';
import '../modules/qus_and_ans/views/qus_and_ans_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/searching/bindings/searching_binding.dart';
import '../modules/searching/views/searching_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.LOGIN;
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAINPAGE,
      page: () => const MainPageView(),
      binding: MainpageBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDER,
      page: () => const MyOrderView(),
      binding: MyOrderBinding(),
      children: [
        GetPage(
          name: _Paths.ORDER_DETAILS,
          page: () => const OrderDetailsView(),
          binding: OrderDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
      children: [
        GetPage(
          name: _Paths.PRODUCT_DETAILS,
          page: () => const ProductDetailsView(),
          binding: ProductDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      children: [
        GetPage(
          name: _Paths.VERIFY_O_T_P,
          page: () => const VerifyOTPView(),
          binding: VerifyOTPBinding(),
        ),
        GetPage(
          name: _Paths.CHANGE_PASSWORD,
          page: () => const ChangePasswordView(),
          binding: ChangePasswordBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.PAYMENT_METHODS,
          page: () => const PaymentMethodsView(),
          binding: PaymentMethodsBinding(),
          children: [
            GetPage(
              name: _Paths.ADD_NEW_PAYMENT,
              page: () => const AddNewPaymentView(),
              binding: AddNewPaymentBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.EDIT_PROFILE,
          page: () => const EditProfileView(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: _Paths.SETTINGS,
          page: () => const SettingsView(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: _Paths.ACCOUNT_AND_SECURITY,
          page: () => const AccountAndSecurityView(),
          binding: AccountAndSecurityBinding(),
        ),
        GetPage(
          name: _Paths.HELP_AND_SUPPORT,
          page: () => const HelpAndSupportView(),
          binding: HelpAndSupportBinding(),
        ),
        GetPage(
          name: _Paths.NOTIFICATIONS,
          page: () => const NotificationsView(),
          binding: NotificationsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHOOSE_DELIVERY_ADDRESS,
      page: () => const ChooseDeliveryAddressView(),
      binding: ChooseDeliveryAddressBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_DELIVERY_ADDRESS,
          page: () => const AddDeliveryAddressView(),
          binding: AddDeliveryAddressBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHOOSE_DELIVERY,
      page: () => const ChooseDeliveryView(),
      binding: ChooseDeliveryBinding(),
    ),
    GetPage(
      name: _Paths.PROMOS_VOUCHERS,
      page: () => const PromosVouchersView(),
      binding: PromosVouchersBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    // GetPage(
    //   name: _Paths.AUTH,
    //   page: () => const AuthView(),
    //   binding: AuthBinding(),
    // ),
    GetPage(
      name: _Paths.SEARCHING,
      page: () => const SearchingView(),
      binding: SearchingBinding(),
    ),
    GetPage(
      name: _Paths.FLASH_SALES,
      page: () => const FlashSalesView(),
      binding: FlashSalesBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_REVIEW,
      page: () => const LeaveReviewView(),
      binding: LeaveReviewBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD_PAGE,
      page: () => const OnboardPageView(),
      binding: OnboardPageBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.QUS_AND_ANS,
      page: () => const QusAndAnsView(),
      binding: QusAndAnsBinding(),
    ),
    GetPage(
      name: _Paths.CHATS,
      page: () => const ChatsView(),
      binding: ChatsBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
    ),
  ];
}
