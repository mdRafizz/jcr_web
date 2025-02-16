import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:job_circular2/app/widgets/drawer_content.dart';
import 'package:job_circular2/app/routes/app_pages.dart';
import 'package:job_circular2/app/widgets/end_side_menu_for_web.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart' as rf;
import '../../../widgets/custom_search_bar.dart';
import '../../../widgets/post_list.dart';
import '../../../widgets/reusable_text.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/side_menu_for_web.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      'Circular',
      'Result',
      'Notice',
      'Notes',
      'About Us',
    ];
    final List<void Function()> menuActions = [
      //circular
      () {
        Get.toNamed(Routes.CIRCULAR);
      },
      //result
      () {
        Get.toNamed(Routes.RESULT);
      },
      //notice
      () {
        Get.toNamed(Routes.NOTICE);
      },
      //notes
      () {
        Get.toNamed(Routes.NOTES);
      },
      //about us
      () {
        Get.toNamed(Routes.ABOUT_US);
      },
    ];
    var isDesktop = rf.ResponsiveBreakpoints.of(context).isDesktop;
    print(Get.width);

    return Scaffold(
      drawer: Drawer(
        child: DrawerContent(
          controller: controller,
          title: 'Filter Posts',
        ),
      ),
      endDrawer: Drawer(
        child: Container(),
      ),
      backgroundColor: CupertinoColors.systemGrey6,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/rb_2150647153.png'),
            opacity: .05,
            fit: BoxFit.fill,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            CustomAppBar(
              menuItems: menuItems,
              menuActions: menuActions,
              // controller: controller,
              appbarTitle: 'Home',
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop)
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300),
                      child: SizedBox(
                        width: rf.ResponsiveValue<double>(
                          context,
                          defaultValue: Get.width * 0.25,
                          // Default Desktop Size
                          conditionalValues: [
                            rf.Condition.between(
                              start: 800,
                              end: 1110,
                              value: Get.width * 0.35,
                            ),
                          ],
                        ).value,
                        child: Center(
                          child: SideMenuForWeb(
                            controller: controller,
                            title: 'Filter Posts',
                          ),
                        ),
                      ),
                    ),
                  if (isDesktop) Gap(20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Align(
                          alignment:
                              rf.ResponsiveBreakpoints.of(context).screenWidth >
                                      1150
                                  ? Alignment.center
                                  : isDesktop
                                      ? Alignment.centerLeft
                                      : Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isDesktop ? 700 : double.maxFinite,
                            ),
                            child: Container(
                              width: isDesktop
                                  ? rf.ResponsiveValue<double>(
                                      context,
                                      defaultValue: Get.width * 0.55,
                                      conditionalValues: [
                                        rf.Condition.between(
                                          start: 800,
                                          end: 1110,
                                          value: Get.width * 0.6,
                                        ),
                                      ],
                                    ).value
                                  : double.maxFinite,
                              margin: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 0 : 20,
                              ),
                              child: Obx(() {
                                if (controller.isLoading.value) {
                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 80,
                                    child: Center(
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballRotateChase,
                                          colors: [
                                            const Color(0xFF1d9279),
                                            Colors.blue,
                                            const Color(0xffFF00FF),
                                            Colors.green,
                                            Colors.cyan,
                                            Colors.yellow,
                                            Colors.red,
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (controller.posts.isEmpty) {
                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 80,
                                    child: Center(
                                      child: ReusableText('No posts found.'),
                                    ),
                                  );
                                }

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Gap(14),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomSearchBar(
                                              controller: controller,
                                            ),
                                          ),
                                          Gap(8),
                                          MaterialButton(
                                            onPressed: () {},
                                            color: const Color(0xFF1d9279),
                                            height: 55,
                                            elevation: 0,
                                            minWidth: 70,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                            child: Icon(
                                              CupertinoIcons.search,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gap(14),
                                    PostList(
                                      controller: controller,
                                      isFromHome: true,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (rf.ResponsiveBreakpoints.of(context).screenWidth > 1150)
                    Row(
                      children: [
                        Gap(15),
                        SizedBox(
                          width: Get.width * 0.2,
                          child: Center(
                            child: EndSideMenuForWeb(),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getResponsiveWidth(double screenWidth) {
    return lerpDouble(0.55, 0.55, (screenWidth - 801) / (1920 - 801))! *
        screenWidth;
  }

  // Sidebar Width
  double getResponsiveSidebarWidth(double screenWidth) {
    return lerpDouble(0.25, 0.35, (screenWidth - 801) / (1920 - 801))! *
        screenWidth;
  }
}
