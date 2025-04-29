import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

 List<TabItem> navItems = [
   TabItem(
    icon: MdiIcons.home,
    title: "Home".tr,
  ),
   TabItem(
    icon: Icons.category,
    title: 'Categories'.tr,
  ),
   TabItem(
    icon: MdiIcons.crownOutline,
    title: 'Cart'.tr,
  ),
   TabItem(
    icon: Icons.shopping_bag_rounded,
    title: 'My Order'.tr,
  ),
   TabItem(
    icon: Icons.person,
    title: 'Profile'.tr,
  ),
];