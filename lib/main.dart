import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  if (kIsWeb) {
    usePathUrlStrategy();
    // setUrlStrategy(PathUrlStrategy());
  }

  runApp(
    JobCircularResult(),
  );
}

class JobCircularResult extends StatelessWidget {
  const JobCircularResult({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Job Circular & Result',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'bn',
        brightness: Brightness.light,
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData(
          thickness: WidgetStateProperty.all<double>(3),
          radius: Radius.circular(3),
        )
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        ],
      ),
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ).animate().fadeIn(duration: 400.ms);
  }
}

