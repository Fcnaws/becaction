import 'package:flutter/material.dart';
import 'package:ignis/screens/home_page.dart';
import 'package:ignis/screens/calculator_page.dart';
import 'package:ignis/screens/live_map_page.dart';
import 'package:ignis/screens/fire_evolution_page.dart';
import 'package:ignis/screens/impact_dashboard_page.dart';
import 'package:ignis/screens/faq_page.dart';

class AppRouter {
  // route name path
  static const String home = '/';
  static const String calculator = '/calculator';
  static const String liveMap = '/live-map';
  static const String fireEvolution = '/fire-evolution';
  static const String impactDashboard = '/impact-dashboard';
  static const String faq = '/faq';
  static const String login = '/login';
  static const String signup = '/signup';

  // routes
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(const HomePage());
      case calculator:
        return _buildRoute(const CalculatorPage());
      case liveMap:
        return _buildRoute(const LiveMapPage());
      case fireEvolution:
        return _buildRoute(const FireEvolutionPage());
      case impactDashboard:
        return _buildRoute(const ImpactDashboardPage());
      case faq:
        return _buildRoute(const FAQPage());
      default:
        return _buildRoute(const HomePage());
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }
  
  // Helper nav
  static void navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}