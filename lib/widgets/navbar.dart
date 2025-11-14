import 'package:flutter/material.dart';
import 'package:ignis/core/constants/app_text.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/core/navigation/nav_item.dart';

class Navbar extends StatelessWidget {
  final double? horizontalPadding;
  const Navbar({super.key, this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    final pad = horizontalPadding ?? context.horizontalPad;

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: 18),
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LOGO
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 42,
                      height: 42,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      WebpageText.headerLogoText, // "IGNIS"
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),

            if (!context.isSmall)
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - (pad * 2) - 280,
                  ),
                  child: Wrap(
                    spacing: 28,
                    alignment: WrapAlignment.center,
                    children: WebpageNav.items.map((item) {
                      return TextButton(
                        onPressed: () => Navigator.pushNamed(context, item.route),
                        style: ButtonStyle(
                          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                          minimumSize: const WidgetStatePropertyAll(Size(0, 0)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.hovered) ||
                                states.contains(WidgetState.focused) ||
                                states.contains(WidgetState.pressed)) {
                              return AppColors.primary;
                            }
                            return AppColors.secondary;
                          }),
                          overlayColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return AppColors.tint3.withOpacity(0.25);
                            }
                            if (states.contains(WidgetState.hovered)) {
                              return AppColors.tint3.withOpacity(0.12);
                            }
                            return Colors.transparent;
                          }),
                          textStyle: WidgetStatePropertyAll(
                            Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        child: Text(item.label),
                      );
                    }).toList(),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
