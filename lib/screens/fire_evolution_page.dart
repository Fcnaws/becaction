import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/site_layout.dart';

class FireEvolutionPage extends StatefulWidget {
  const FireEvolutionPage({super.key});

  @override
  State<FireEvolutionPage> createState() => _FireEvolutionPageState();
}

class _FireEvolutionPageState extends State<FireEvolutionPage> {
  String selectedFire = 'Leiria Pine Forest';
  int selectedTimeIndex = 5; // Current time

  final List<String> activeFires = [
    'Leiria Pine Forest',
    'Serra da Estrela',
    'Monchique',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLarge = context.isLarge;

    return SiteLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fire Evolution Tracker",
                      style: textTheme.displayMedium?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Track and predict fire progression over time",
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Fire Selector
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.silver,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: activeFires
                  .map((fire) => _FireTab(
                        label: fire,
                        isSelected: selectedFire == fire,
                        onTap: () => setState(() => selectedFire = fire),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 30),

          // Main Content
          isLarge
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _EvolutionMap(timeIndex: selectedTimeIndex),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _FireDetails(fireName: selectedFire),
                          const SizedBox(height: 20),
                          _PredictionPanel(),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _FireDetails(fireName: selectedFire),
                    const SizedBox(height: 20),
                    _EvolutionMap(timeIndex: selectedTimeIndex),
                    const SizedBox(height: 20),
                    _PredictionPanel(),
                  ],
                ),
          const SizedBox(height: 30),

          // Timeline Slider
          _TimelineSlider(
            currentIndex: selectedTimeIndex,
            onChanged: (index) => setState(() => selectedTimeIndex = index),
          ),
          const SizedBox(height: 30),

          // Evolution Stats
          _EvolutionStats(),
        ],
      ),
    );
  }
}

class _FireTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FireTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.dGrey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _EvolutionMap extends StatelessWidget {
  final int timeIndex;

  const _EvolutionMap({required this.timeIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.silver,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyBlue.withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          // Map background
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=1200&auto=format&fit=crop',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.2),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Fire spread visualization
          Center(
            child: CustomPaint(
              size: Size(300, 300),
              painter: _FireSpreadPainter(
                progress: timeIndex / 10,
              ),
            ),
          ),

          // Legend
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Fire Spread",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LegendItem(
                    color: AppColors.error,
                    label: "Active Fire",
                  ),
                  _LegendItem(
                    color: AppColors.warning,
                    label: "Predicted (6h)",
                  ),
                  _LegendItem(
                    color: Colors.orange.withOpacity(0.5),
                    label: "Predicted (12h)",
                  ),
                ],
              ),
            ),
          ),

          // Time indicator
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getTimeLabel(timeIndex),
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeLabel(int index) {
    final hours = index * 2;
    if (hours == 0) return "Start";
    if (hours > 10) return "+${hours}h (Predicted)";
    return "+${hours}h";
  }
}

class _FireSpreadPainter extends CustomPainter {
  final double progress;

  _FireSpreadPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw multiple concentric circles to show fire spread
    for (int i = 0; i < 5; i++) {
      final radius = (size.width / 2) * progress * (1 - i * 0.15);
      if (radius > 0) {
        final paint = Paint()
          ..color = _getColorForRing(i)
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(center, radius, paint);
      }
    }
  }

  Color _getColorForRing(int ring) {
    switch (ring) {
      case 0:
        return AppColors.error.withOpacity(0.9);
      case 1:
        return AppColors.error.withOpacity(0.7);
      case 2:
        return AppColors.warning.withOpacity(0.6);
      case 3:
        return Colors.orange.withOpacity(0.4);
      default:
        return Colors.orange.withOpacity(0.2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _FireDetails extends StatelessWidget {
  final String fireName;

  const _FireDetails({required this.fireName});

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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: AppColors.error,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fireName,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Active • High Severity",
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _DetailRow(Icons.terrain, "Current Area", "420 hectares"),
          _DetailRow(Icons.speed, "Spread Rate", "2.3 ha/hour"),
          _DetailRow(Icons.air, "Wind Speed", "25 km/h NE"),
          _DetailRow(Icons.thermostat, "Temperature", "32°C"),
          _DetailRow(Icons.water_drop, "Humidity", "18%"),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PredictionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.warning, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_graph, color: AppColors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                "24h Prediction",
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _PredictionItem("Estimated Area", "850 hectares", Icons.trending_up),
          _PredictionItem("Containment", "35% likely", Icons.shield),
          _PredictionItem("Risk Level", "Very High", Icons.warning),
        ],
      ),
    );
  }
}

class _PredictionItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _PredictionItem(this.label, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.white.withOpacity(0.9)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white.withOpacity(0.9),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineSlider extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const _TimelineSlider({
    required this.currentIndex,
    required this.onChanged,
  });

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
            "Timeline",
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.error,
              inactiveTrackColor: AppColors.silver,
              thumbColor: AppColors.error,
              overlayColor: AppColors.error.withOpacity(0.2),
              trackHeight: 8,
            ),
            child: Slider(
              value: currentIndex.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              label: _getTimeLabel(currentIndex),
              onChanged: (value) => onChanged(value.toInt()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start",
                style: textTheme.bodySmall?.copyWith(color: AppColors.grey),
              ),
              Text(
                "Now",
                style: textTheme.bodySmall?.copyWith(color: AppColors.grey),
              ),
              Text(
                "+20h",
                style: textTheme.bodySmall?.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTimeLabel(int index) {
    final hours = index * 2;
    return hours == 0 ? "Start" : "+${hours}h";
  }
}

class _EvolutionStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final isSmall = context.isSmall;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isLarge ? 4 : (isSmall ? 2 : 3),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: const [
        _StatCard(
          icon: Icons.speed,
          value: "2.3",
          unit: "ha/hr",
          label: "Spread Rate",
          color: AppColors.error,
        ),
        _StatCard(
          icon: Icons.trending_up,
          value: "+180",
          unit: "ha",
          label: "Growth (6h)",
          color: AppColors.warning,
        ),
        _StatCard(
          icon: Icons.location_on,
          value: "3.2",
          unit: "km",
          label: "Perimeter",
          color: AppColors.info,
        ),
        _StatCard(
          icon: Icons.access_time,
          value: "8",
          unit: "hours",
          label: "Active Time",
          color: AppColors.shade2,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                    ),
                  ),
                ],
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
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