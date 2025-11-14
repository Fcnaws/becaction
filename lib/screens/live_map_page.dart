import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/site_layout.dart';

class LiveMapPage extends StatefulWidget {
  const LiveMapPage({super.key});

  @override
  State<LiveMapPage> createState() => _LiveMapPageState();
}

class _LiveMapPageState extends State<LiveMapPage> {
  String selectedFilter = 'All';
  
  // Dados de exemplo de incêndios ativos
  final List<FireData> activeFires = [
    FireData(
      id: '001',
      location: 'Serra da Estrela',
      district: 'Guarda',
      status: 'Active',
      severity: 'High',
      area: '250 ha',
      startTime: '2 hours ago',
    ),
    FireData(
      id: '002',
      location: 'Monchique',
      district: 'Faro',
      status: 'Controlled',
      severity: 'Moderate',
      area: '85 ha',
      startTime: '5 hours ago',
    ),
    FireData(
      id: '003',
      location: 'Leiria Pine Forest',
      district: 'Leiria',
      status: 'Active',
      severity: 'Extreme',
      area: '420 ha',
      startTime: '30 minutes ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final textTheme = Theme.of(context).textTheme;

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
                      "Live Fire Map",
                      style: textTheme.displayMedium?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Real-time tracking of active forest fires",
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.error, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "3 Active Fires",
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Filters
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ['All', 'Active', 'Controlled', 'Resolved']
                .map((filter) => _FilterChip(
                      label: filter,
                      isSelected: selectedFilter == filter,
                      onTap: () => setState(() => selectedFilter = filter),
                    ))
                .toList(),
          ),
          const SizedBox(height: 30),

          // Map and List
          isLarge
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _MapPlaceholder(),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: _FiresList(fires: activeFires),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _MapPlaceholder(),
                    const SizedBox(height: 30),
                    _FiresList(fires: activeFires),
                  ],
                ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.silver,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyBlue,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.dGrey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.silver,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyBlue.withOpacity(0.3)),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=1200&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Stack(
        children: [
          // Fire markers (example positions)
          Positioned(
            top: 120,
            left: 180,
            child: _FireMarker(severity: 'High'),
          ),
          Positioned(
            bottom: 200,
            right: 150,
            child: _FireMarker(severity: 'Moderate'),
          ),
          Positioned(
            top: 250,
            right: 200,
            child: _FireMarker(severity: 'Extreme'),
          ),
          
          // Map controls
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              children: [
                _MapControl(icon: Icons.add, onTap: () {}),
                const SizedBox(height: 8),
                _MapControl(icon: Icons.remove, onTap: () {}),
                const SizedBox(height: 8),
                _MapControl(icon: Icons.my_location, onTap: () {}),
              ],
            ),
          ),
          
          // Legend
          Positioned(
            bottom: 20,
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
                    "Severity Legend",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _LegendItem(color: AppColors.error, label: "Extreme"),
                  _LegendItem(color: Colors.orange, label: "High"),
                  _LegendItem(color: AppColors.warning, label: "Moderate"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FireMarker extends StatelessWidget {
  final String severity;

  const _FireMarker({required this.severity});

  Color _getColor() {
    switch (severity) {
      case 'Extreme':
        return AppColors.error;
      case 'High':
        return Colors.orange;
      case 'Moderate':
        return AppColors.warning;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getColor(),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: _getColor().withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.local_fire_department,
        color: AppColors.white,
        size: 20,
      ),
    );
  }
}

class _MapControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapControl({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppColors.secondary),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
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

class _FiresList extends StatelessWidget {
  final List<FireData> fires;

  const _FiresList({required this.fires});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Active Fires",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        ...fires.map((fire) => _FireCard(fire: fire)),
      ],
    );
  }
}

class _FireCard extends StatelessWidget {
  final FireData fire;

  const _FireCard({required this.fire});

  Color _getSeverityColor() {
    switch (fire.severity) {
      case 'Extreme':
        return AppColors.error;
      case 'High':
        return Colors.orange;
      case 'Moderate':
        return AppColors.warning;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getSeverityColor().withOpacity(0.3),
          width: 2,
        ),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getSeverityColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_fire_department,
                  color: _getSeverityColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fire.location,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      fire.district,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getSeverityColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  fire.severity,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoRow(icon: Icons.terrain, label: "Area", value: fire.area),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.access_time, label: "Started", value: fire.startTime),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.circle,
            label: "Status",
            value: fire.status,
            valueColor: fire.status == 'Active' ? AppColors.error : AppColors.success,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.grey),
        const SizedBox(width: 8),
        Text(
          "$label:",
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.black,
          ),
        ),
      ],
    );
  }
}

class FireData {
  final String id;
  final String location;
  final String district;
  final String status;
  final String severity;
  final String area;
  final String startTime;

  FireData({
    required this.id,
    required this.location,
    required this.district,
    required this.status,
    required this.severity,
    required this.area,
    required this.startTime,
  });
}