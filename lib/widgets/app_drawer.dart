import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/theme/app_typography.dart';
import 'package:ignis/core/routing/app_router.dart';
import 'package:ignis/core/navigation/nav_item.dart'; // <- usa WebpageNav.items

class AppNavDrawer extends StatelessWidget {
  const AppNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTypography.textTheme;

    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 36,
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    WebpageNav.brand, // "IGNIS"
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ...WebpageNav.items.map(
            (item) => ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              title: Text(
                item.label,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.greyBlue,
                size: 20,
              ),
              hoverColor: AppColors.tint4,
              onTap: () {
                Navigator.pop(context); // close drawer
                Navigator.pushNamed(context, item.route);
              },
            ),
          ),

          const Divider(
            color: AppColors.greyBlue,
            thickness: 0.5,
            height: 32,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.login);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    textStyle: textTheme.titleSmall,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Login"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRouter.signup);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    textStyle: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
