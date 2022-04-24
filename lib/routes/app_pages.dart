import 'package:to_do_app/nav_pages/nav_page.dart';
import 'package:to_do_app/ui/onboarding_page.dart';
import 'app_routes.dart';

class AppPages {
  static final page = {
    AppRoutes.navPage: (context) => NavPage(),
    AppRoutes.onBoarding: (context) => OnboardingPage(),
  };
}
