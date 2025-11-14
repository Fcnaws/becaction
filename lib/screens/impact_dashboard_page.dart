import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/site_layout.dart';

// IMPORTANTE: O nome da classe deve ser exatamente ImpactDashboardPage (com I maiúsculo)
// E o arquivo deve ser: lib/screens/impact_dashboard_page.dart

class ImpactDashboardPage extends StatelessWidget {
  const ImpactDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLarge = context.isLarge;
    final isSmall = context.isSmall;

    return SiteLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Impact Dashboard",
            style: textTheme.displayMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Comprehensive analysis of forest fire impacts",
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 40),

          // Year Selector
          Row(
            children: [
              Text(
                "Year: ",
                style: textTheme.titleMedium,
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greyBlue),
                ),
                child: DropdownButton<int>(
                  value: 2024,
                  underline: const SizedBox.shrink(),
                  items: [2024, 2023, 2022, 2021]
                      .map((year) => DropdownMenuItem(
                            value: year,
                            child: Text(year.toString()),
                          ))
                      .toList(),
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Key Metrics Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isLarge ? 4 : (isSmall ? 2 : 3),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isSmall ? 1.3 : 1.5,
            children: const [
              _MetricCard(
                icon: Icons.local_fire_department,
                value: "342",
                label: "Total Fires",
                color: AppColors.error,
                trend: "+12%",
                trendUp: true,
              ),
              _MetricCard(
                icon: Icons.terrain,
                value: "45,230",
                label: "Hectares Burned",
                color: AppColors.warning,
                trend: "-8%",
                trendUp: false,
              ),
              _MetricCard(
                icon: Icons.eco,
                value: "2.3M",
                label: "Trees Lost",
                color: AppColors.shade2,
                trend: "+15%",
                trendUp: true,
              ),
              _MetricCard(
                icon: Icons.monetization_on,
                value: "€85M",
                label: "Economic Impact",
                color: AppColors.info,
                trend: "+22%",
                trendUp: true,
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Charts Section
          isLarge
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _MonthlyFiresChart()),
                    const SizedBox(width: 20),
                    Expanded(child: _ImpactBreakdownChart()),
                  ],
                )
              : Column(
                  children: [
                    _MonthlyFiresChart(),
                    const SizedBox(height: 20),
                    _ImpactBreakdownChart(),
                  ],
                ),
          const SizedBox(height: 40),

          // Regional Impact Table
          _RegionalImpactTable(),
          const SizedBox(height: 40),

          // Environmental Impact
          _EnvironmentalImpact(),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final String? trend;
  final bool? trendUp;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.trend,
    this.trendUp,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: trendUp! ? AppColors.error.withOpacity(0.1) : AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendUp! ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: trendUp! ? AppColors.error : AppColors.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trend!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: trendUp! ? AppColors.error : AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthlyFiresChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Fire Occurrences",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          // Simplified bar chart visualization
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ChartBar(height: 60, label: "J", value: "12"),
                _ChartBar(height: 40, label: "F", value: "8"),
                _ChartBar(height: 70, label: "M", value: "15"),
                _ChartBar(height: 90, label: "A", value: "22"),
                _ChartBar(height: 120, label: "M", value: "35"),
                _ChartBar(height: 150, label: "J", value: "48"),
                _ChartBar(height: 180, label: "J", value: "65"),
                _ChartBar(height: 170, label: "A", value: "58"),
                _ChartBar(height: 140, label: "S", value: "42"),
                _ChartBar(height: 100, label: "O", value: "28"),
                _ChartBar(height: 50, label: "N", value: "10"),
                _ChartBar(height: 45, label: "D", value: "9"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final double height;
  final String label;
  final String value;

  const _ChartBar({
    required this.height,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "$label: $value fires",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Container(
            width: 20,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.warning, AppColors.error],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}

class _ImpactBreakdownChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Impact by Category",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          _ImpactBar(
            label: "Ecological",
            percentage: 85,
            color: AppColors.shade2,
          ),
          const SizedBox(height: 16),
          _ImpactBar(
            label: "Economic",
            percentage: 72,
            color: AppColors.warning,
          ),
          const SizedBox(height: 16),
          _ImpactBar(
            label: "Social",
            percentage: 58,
            color: AppColors.info,
          ),
          const SizedBox(height: 16),
          _ImpactBar(
            label: "Infrastructure",
            percentage: 45,
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class _ImpactBar extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _ImpactBar({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${percentage.toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 12,
            backgroundColor: AppColors.silver,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _RegionalImpactTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Regional Impact Summary",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          _RegionalRow("Aveiro", "45", "3,240", AppColors.error),
          _RegionalRow("Faro", "38", "2,890", AppColors.warning),
          _RegionalRow("Leiria", "52", "4,120", AppColors.error),
          _RegionalRow("Guarda", "31", "2,340", AppColors.warning),
          _RegionalRow("Vila Real", "28", "1,950", AppColors.success),
        ],
      ),
    );
  }
}

class _RegionalRow extends StatelessWidget {
  final String region;
  final String fires;
  final String hectares;
  final Color color;

  const _RegionalRow(this.region, this.fires, this.hectares, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              region,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text("$fires fires"),
          ),
          Expanded(
            child: Text("$hectares ha"),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvironmentalImpact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.shade3, AppColors.shade2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Environmental Impact",
            style: textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            children: [
              _EnvStat("2.3M", "Trees Lost", Icons.eco),
              _EnvStat("45K", "Hectares Burned", Icons.terrain),
              _EnvStat("850K", "CO₂ Tons Emitted", Icons.cloud),
              _EnvStat("125", "Species Affected", Icons.pets),
            ],
          ),
        ],
      ),
    );
  }
}

class _EnvStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _EnvStat(this.value, this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.white, size: 32),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.white.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}