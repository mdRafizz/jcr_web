import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_circular2/app/modules/home/controllers/home_controller.dart';
import 'package:job_circular2/app/widgets/main_content.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart' as rf;

import '../../../routes/app_pages.dart';
import '../../../widgets/blurred_drawer.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_search_bar.dart';
import '../../../widgets/drawer_content.dart';
import '../../../widgets/end_drawer_content.dart';
import '../../../widgets/end_side_menu_for_web.dart';
import '../../../widgets/post_list.dart';
import '../../../widgets/reusable_text.dart';
import '../../../widgets/side_menu_for_web.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> menuRoutes = {
      'Circular': Routes.CIRCULAR,
      'Result': Routes.RESULT,
      'Notice': Routes.NOTICE,
      'Notes': Routes.NOTES,
      'About Us': Routes.ABOUT_US,
    };

    final isDesktop = rf.ResponsiveBreakpoints.of(context).isDesktop;
    final screenWidth = Get.width;

    return Scaffold(
      drawer: BlurredDrawer(
        child: DrawerContent(
          title: 'Filter Posts',
          controller: controller,
        ),
      ),
      endDrawer: const BlurredDrawer(
        isEndDrawer: true,
        child: EndDrawerContent(),
      ),
      backgroundColor: CupertinoColors.systemGrey6,
      body: Container(
        decoration: _backgroundDecoration(),
        child: Column(
          children: [
            CustomAppBar(
              menuItems: menuRoutes.keys.toList(),
              menuActions: menuRoutes.values
                  .map((route) => () => Get.toNamed(route))
                  .toList(),
              appbarTitle: 'Home',
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop)
                    SizedBox(
                      width: _getSidebarWidth(context),
                      child: Center(
                        child: SideMenuForWeb(
                          title: 'Filter Posts',
                          controller: controller,
                        ),
                      ),
                    ),
                  if (isDesktop) const SizedBox(width: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: isDesktop
                              ? Alignment.centerLeft
                              : Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isDesktop ? 700 : double.infinity,
                            ),
                            child: MainContent(
                              title: 'post',
                              controller: controller,
                              fromHome: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (screenWidth > 1150)
                    SizedBox(
                      width: screenWidth * 0.2,
                      child: const EndSideMenuForWeb(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _backgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/bg/rb_2150647153.png'),
        opacity: .05,
        fit: BoxFit.fill,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  double _getSidebarWidth(BuildContext context) {
    return rf.ResponsiveValue<double>(
      context,
      defaultValue: Get.width * 0.25,
      conditionalValues: [
        rf.Condition.between(
          start: 800,
          end: 1110,
          value: Get.width * 0.35,
        )
      ],
    ).value;
  }
}
