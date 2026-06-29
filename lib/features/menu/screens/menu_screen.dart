import 'package:stackfood_multivendor_restaurant/features/profile/controllers/profile_controller.dart';
import 'package:stackfood_multivendor_restaurant/features/profile/domain/models/employed_permission_model.dart';
import 'package:stackfood_multivendor_restaurant/features/profile/domain/models/profile_model.dart';
import 'package:stackfood_multivendor_restaurant/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor_restaurant/features/menu/domain/models/menu_model.dart';
import 'package:stackfood_multivendor_restaurant/features/menu/widgets/menu_button_widget.dart';
import 'package:stackfood_multivendor_restaurant/helper/route_helper.dart';
import 'package:stackfood_multivendor_restaurant/util/dimensions.dart';
import 'package:stackfood_multivendor_restaurant/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  final int crossAxisCount = 4;

  @override
  Widget build(BuildContext context) {

    Restaurant? restaurant = Get.find<ProfileController>().profileModel != null ? Get.find<ProfileController>().profileModel!.restaurants![0] : null;

    ModulePermissionModel modulePermission = Get.find<ProfileController>().modulePermission ?? ModulePermissionModel();

    final List<MenuModel> menuList = [];

    menuList.add(MenuModel(icon: '', title: 'edit_profile'.tr, route: RouteHelper.getUpdateProfileRoute()));
    if(Get.find<ProfileController>().profileModel == null){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Get.offAllNamed(RouteHelper.initial);
      });
      return SizedBox();
    }

    if(modulePermission.food ?? false){
      menuList.add(MenuModel(
        icon: Images.addFood, title: 'all_food'.tr, route: RouteHelper.getAllProductsRoute(),
        isBlocked: !Get.find<ProfileController>().profileModel!.restaurants![0].foodSection!,
      ));
    }

    if(modulePermission.campaign  ?? false){
      menuList.add(MenuModel(icon: Images.campaign, title: 'campaign'.tr, route: RouteHelper.getCampaignRoute()));
    }

    if(modulePermission.restaurantConfig ?? false){
      // Get.dialog(CustomLoaderWidget());
      // Get.find<ProfileController>().getProfile().then((value) {
      //   Get.back();
      //   restaurant = Get.find<ProfileController>().profileModel!.restaurants![0];
        menuList.add(MenuModel(icon: Images.settingIcon, title: 'restaurant_config'.tr, route: RouteHelper.getRestaurantSettingRoute(restaurant)));
      // });
    }

    if(restaurant?.selfDeliverySystem == 1) {
      menuList.add(MenuModel(
        icon: Images.deliveryMan, iconColor: Colors.white, title: 'delivery_man'.tr, route: RouteHelper.getDeliveryManRoute(),
      ));
    }

    if(modulePermission.adsList ?? false){
      menuList.add(MenuModel(icon: Images.adsMenu, title: 'advertisements'.tr, route: RouteHelper.getAdvertisementListRoute()));
    }

    final bool reelsModuleOn = Get.find<SplashController>().configModel?.reelsModule?.vendorCanUploadReels ?? false;
    final bool reelsPermission = modulePermission.reels ?? true;

    print(reelsModuleOn);
    print(reelsPermission);
    if(reelsModuleOn && reelsPermission){
      menuList.add(MenuModel(icon: Images.reels, title: 'reels'.tr, route: RouteHelper.getReelsRoute()));
    }

    if(modulePermission.addon  ?? false){
      menuList.add(MenuModel(icon: Images.addon, title: 'addons'.tr, route: RouteHelper.getAddonsRoute()));
    }

    if(modulePermission.category ?? false){
      menuList.add(MenuModel(icon: Images.categories, title: 'categories'.tr, route: RouteHelper.getCategoriesRoute()));
    }

    if(modulePermission.coupon ?? false){
      menuList.add(MenuModel(icon: Images.coupon, title: 'coupon'.tr, route: RouteHelper.getCouponRoute()));
    }

    if(modulePermission.businessPlan  ?? false){
      menuList.add(MenuModel(icon: Images.subscription, iconColor: Colors.white, title: 'my_business_plan'.tr, route: RouteHelper.getMySubscriptionRoute()));
    }

    if(modulePermission.reviews ?? false){
      menuList.add(MenuModel(icon: Images.review, title: 'reviews'.tr, route: RouteHelper.getCustomerReviewRoute()));
    }

    if((modulePermission.expenseReport ?? false) || (modulePermission.transaction ?? false) || (modulePermission.orderReport ?? false) || (modulePermission.foodReport ?? false) || (modulePermission.taxReport  ?? false)){
      menuList.add(MenuModel(icon: Images.reportsIcon, title: 'reports'.tr, route: RouteHelper.getReportsRoute()));
    }

    if(modulePermission.disbursement ?? false){
      if(Get.find<SplashController>().configModel!.disbursementType == 'automated'){
        menuList.add(MenuModel(icon: Images.disbursementIcon, title: 'disbursement'.tr, route: RouteHelper.getDisbursementRoute()));
      }
    }

    if(modulePermission.walletMethod ?? false){
      menuList.add(MenuModel(icon: Images.walletMethodIcon, title: 'wallet_method'.tr, route: RouteHelper.getWithdrawMethodRoute()));
    }

    menuList.add(MenuModel(icon: Images.language, title: 'language'.tr, route: '', isLanguage: true));
    menuList.add(MenuModel(icon: Images.settingIcon, title: 'settings'.tr, route: RouteHelper.getSettingRoute()));

    if(modulePermission.chat ?? false){
      menuList.add(
        MenuModel(
        icon: Images.chat, title: 'conversation'.tr, route: RouteHelper.getConversationListRoute(),
        isNotSubscribe: (Get.find<ProfileController>().profileModel!.restaurants![0].restaurantModel == 'subscription'
          && Get.find<ProfileController>().profileModel!.subscription != null && Get.find<ProfileController>().profileModel!.subscription!.chat == 0),
        ),
      );
    }

    menuList.add(MenuModel(icon: Images.policy, title: 'privacy_policy'.tr, route: RouteHelper.getPrivacyRoute()));

    menuList.add(MenuModel(icon: Images.terms, title: 'terms_condition'.tr, route: RouteHelper.getTermsRoute()));

    menuList.add(MenuModel(icon: Images.logOut, title: 'logout'.tr, route: ''));

    return  Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      width: double.infinity,
        padding: const EdgeInsets.only(
          left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault,
          bottom: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeExtraSmall,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
          color: Theme.of(context).cardColor,
        ),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
          
            Container(
              height: 5, width: 50,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            LayoutBuilder(
              builder: (context, constants) {
                final double width = constants.maxWidth;
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: Dimensions.paddingSizeDefault,
                  children: List.generate(menuList.length, (index) {
                    return SizedBox(
                      width: (width - Dimensions.paddingSizeDefault * crossAxisCount - 1) / crossAxisCount,
                      child: MenuButtonWidget(menu: menuList[index], isProfile: index == 0, isLogout: index == menuList.length-1, height: (width - Dimensions.paddingSizeDefault * crossAxisCount - 1) / crossAxisCount),
                    );
                  }),
                );
              },
            ),

          ]),
        ),
      );
  }
}