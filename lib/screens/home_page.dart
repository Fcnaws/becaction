import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/site_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      child: Column(
        children: [
          _HeroSection(),
          const SizedBox(height: 80),
          _AboutSection(),
          const SizedBox(height: 80),
          _FeaturesSection(),
          const SizedBox(height: 80),
          _StatsSection(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

// HERO SECTION
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final isSmall = context.isSmall;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: isLarge
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: _HeroContent(),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 4,
                  child: _HeroImage(height: 500),
                ),
              ],
            )
          : Column(
              children: [
                _HeroContent(),
                const SizedBox(height: 40),
                _HeroImage(height: isSmall ? 280 : 400),
              ],
            ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final w = context.screenWidth;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge/Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.tint5,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.tint3, width: 1),
          ),
          child: Text(
            "🔥 Forest Fire Monitoring",
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.shade2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Main Headline
        Text(
          "Track & Prevent",
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w800,
            fontSize: isLarge ? 64 : (w > 450 ? 48 : 40),
            height: 1.1,
          ),
        ),
        Text(
          "Forest Fires",
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: isLarge ? 64 : (w > 450 ? 48 : 40),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        Text(
          "Real-time monitoring and analysis of forest fires across Portugal. "
          "Access live data, risk predictions, and impact assessments to protect our forests.",
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.grey,
            fontSize: isLarge ? 18 : 16,
            height: 1.6,
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 32),

        // CTAs
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.explore, size: 20),
              label: const Text("Explore Live Map"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calculate, size: 20),
              label: const Text("Risk Calculator"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  final double height;
  const _HeroImage({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          'https://images.unsplash.com/photo-1614935151651-0bea6508db6b?w=1200&auto=format&fit=crop',
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.tint4,
            child: const Center(
              child: Icon(Icons.local_fire_department, size: 80, color: AppColors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

// ABOUT SECTION
class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(isLarge ? 60 : 40),
      decoration: BoxDecoration(
        color: AppColors.silver,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            "About IGNIS",
            style: textTheme.headlineMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "IGNIS is a comprehensive platform for monitoring and analyzing forest fires in Portugal. "
            "We combine real-time data, predictive models, and impact assessments to help communities "
            "and authorities respond effectively to fire emergencies.",
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.dGrey,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

// FEATURES SECTION
class _FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final isSmall = context.isSmall;

    return Column(
      children: [
        Text(
          "Platform Features",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isLarge ? 3 : (isSmall ? 1 : 2),
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: isSmall ? 1.2 : 1.0,
          children: const [
            _FeatureCard(
              icon: Icons.map,
              title: "Live Fire Map",
              description: "Real-time visualization of active forest fires across Portugal",
              color: AppColors.error,
            ),
            _FeatureCard(
              icon: Icons.calculate,
              title: "Risk Calculator",
              description: "Assess fire risk based on weather conditions and location",
              color: AppColors.warning,
            ),
            _FeatureCard(
              icon: Icons.timeline,
              title: "Fire Evolution",
              description: "Track fire progression and predict future behavior",
              color: AppColors.info,
            ),
            _FeatureCard(
              icon: Icons.dashboard,
              title: "Impact Dashboard",
              description: "Analyze environmental and economic impact of fires",
              color: AppColors.shade2,
            ),
            _FeatureCard(
              icon: Icons.notifications_active,
              title: "Alert System",
              description: "Get notified about fires in your area instantly",
              color: AppColors.primary,
            ),
            _FeatureCard(
              icon: Icons.analytics,
              title: "Historical Data",
              description: "Access and analyze historical fire data patterns",
              color: AppColors.tint1,
            ),
          ],
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyBlue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

// STATS SECTION
class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final isSmall = context.isSmall;

    return Container(
      padding: EdgeInsets.all(isLarge ? 60 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.shade2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            "Platform Impact",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: isLarge ? 60 : 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: const [
              _StatItem(
                value: "15K+",
                label: "Active Users",
                color: AppColors.white,
              ),
              _StatItem(
                value: "500+",
                label: "Fires Tracked",
                color: AppColors.white,
              ),
              _StatItem(
                value: "98%",
                label: "Accuracy Rate",
                color: AppColors.white,
              ),
              _StatItem(
                value: "24/7",
                label: "Real-time Monitoring",
                color: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color.withOpacity(0.9),
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}