import 'package:ignis/core/routing/app_router.dart';

class NavItem {
  final String label;
  final String route;

  const NavItem(this.label, this.route);
}

class WebpageNav {
  static const List<NavItem> items = [
    NavItem('Calculator', AppRouter.calculator),
    NavItem('Live Map', AppRouter.liveMap),
    NavItem('Fire Evolution', AppRouter.fireEvolution),
    NavItem('Impact Dashboard', AppRouter.impactDashboard),
    NavItem('FAQ', AppRouter.faq),
  ];

  static const String brand = 'IGNIS';
}
