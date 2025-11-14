import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/navbar.dart';
import 'package:ignis/widgets/app_drawer.dart';
import 'package:ignis/core/constants/app_text.dart';

class SiteLayout extends StatefulWidget {
  final Widget child;
  final Color? background;
  final EdgeInsets? padding;
  final double maxContentWidth;

  const SiteLayout({
    super.key,
    required this.child,
    this.background,
    this.padding,
    this.maxContentWidth = 1240,
  });

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final pad = widget.padding ?? EdgeInsets.symmetric(horizontal: context.horizontalPad);

    final appBar = context.isLarge
        ? PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Navbar(horizontalPadding: context.horizontalPad),
          )
        : AppBar(
            backgroundColor: AppColors.silver,
            elevation: 0,
            toolbarHeight: 80,
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: AppColors.secondary),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                tooltip: 'Menu',
              ),
            ),
            centerTitle: true,
            title: Text(
              WebpageText.headerLogoText, // "IGNIS"
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            actions: [
              // Login but
              TextButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              // Sign up but
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  child: const Text('Sign up'),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AppColors.greyBlue.withOpacity(0.35)),
            ),
          );

    return Scaffold(
      backgroundColor: widget.background ?? Theme.of(context).scaffoldBackgroundColor,

      // Drawer only mobile/tablet
      drawer: context.isLarge ? null : const AppNavDrawer(),
      drawerEdgeDragWidth: context.isSmall ? 24 : null,

      appBar: appBar,

      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widget.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.only(
                left: pad.left,
                right: pad.right,
                top: 24,
                bottom: 32,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
