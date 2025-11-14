import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/site_layout.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double temperature = 25;
  double humidity = 50;
  double windSpeed = 10;
  String vegetation = 'Forest';
  String? riskLevel;
  Color? riskColor;

  void calculateRisk() {
    // Algoritmo simplificado de cálculo de risco
    double risk = 0;
    
    // Temperatura (0-100 pontos)
    risk += (temperature - 10) * 2;
    
    // Humidade (0-100 pontos, inverso)
    risk += (100 - humidity);
    
    // Velocidade do vento (0-100 pontos)
    risk += windSpeed * 3;
    
    // Tipo de vegetação
    if (vegetation == 'Forest') risk += 30;
    if (vegetation == 'Shrubland') risk += 40;
    if (vegetation == 'Grassland') risk += 20;
    
    // Determinar nível de risco
    setState(() {
      if (risk < 100) {
        riskLevel = 'Low Risk';
        riskColor = AppColors.success;
      } else if (risk < 180) {
        riskLevel = 'Moderate Risk';
        riskColor = AppColors.warning;
      } else if (risk < 250) {
        riskLevel = 'High Risk';
        riskColor = Colors.orange;
      } else {
        riskLevel = 'Extreme Risk';
        riskColor = AppColors.error;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLarge;
    final textTheme = Theme.of(context).textTheme;

    return SiteLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Fire Risk Calculator",
            style: textTheme.displayMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Assess the current fire risk based on environmental conditions",
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 40),

          // Calculator Grid
          isLarge
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _InputSection(
                        temperature: temperature,
                        humidity: humidity,
                        windSpeed: windSpeed,
                        vegetation: vegetation,
                        onTemperatureChanged: (v) => setState(() => temperature = v),
                        onHumidityChanged: (v) => setState(() => humidity = v),
                        onWindSpeedChanged: (v) => setState(() => windSpeed = v),
                        onVegetationChanged: (v) => setState(() => vegetation = v),
                        onCalculate: calculateRisk,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 2,
                      child: _ResultSection(
                        riskLevel: riskLevel,
                        riskColor: riskColor,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _InputSection(
                      temperature: temperature,
                      humidity: humidity,
                      windSpeed: windSpeed,
                      vegetation: vegetation,
                      onTemperatureChanged: (v) => setState(() => temperature = v),
                      onHumidityChanged: (v) => setState(() => humidity = v),
                      onWindSpeedChanged: (v) => setState(() => windSpeed = v),
                      onVegetationChanged: (v) => setState(() => vegetation = v),
                      onCalculate: calculateRisk,
                    ),
                    const SizedBox(height: 30),
                    _ResultSection(
                      riskLevel: riskLevel,
                      riskColor: riskColor,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _InputSection extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String vegetation;
  final ValueChanged<double> onTemperatureChanged;
  final ValueChanged<double> onHumidityChanged;
  final ValueChanged<double> onWindSpeedChanged;
  final ValueChanged<String> onVegetationChanged;
  final VoidCallback onCalculate;

  const _InputSection({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.vegetation,
    required this.onTemperatureChanged,
    required this.onHumidityChanged,
    required this.onWindSpeedChanged,
    required this.onVegetationChanged,
    required this.onCalculate,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(32),
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
          Text(
            "Environmental Parameters",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),

          // Temperature
          _SliderInput(
            label: "Temperature",
            value: temperature,
            unit: "°C",
            min: 0,
            max: 50,
            onChanged: onTemperatureChanged,
            icon: Icons.thermostat,
            color: AppColors.error,
          ),
          const SizedBox(height: 24),

          // Humidity
          _SliderInput(
            label: "Humidity",
            value: humidity,
            unit: "%",
            min: 0,
            max: 100,
            onChanged: onHumidityChanged,
            icon: Icons.water_drop,
            color: AppColors.info,
          ),
          const SizedBox(height: 24),

          // Wind Speed
          _SliderInput(
            label: "Wind Speed",
            value: windSpeed,
            unit: "km/h",
            min: 0,
            max: 50,
            onChanged: onWindSpeedChanged,
            icon: Icons.air,
            color: AppColors.greyBlue,
          ),
          const SizedBox(height: 24),

          // Vegetation Type
          Text(
            "Vegetation Type",
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: vegetation,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.silver,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            items: ['Forest', 'Shrubland', 'Grassland', 'Urban']
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (v) => onVegetationChanged(v!),
          ),
          const SizedBox(height: 32),

          // Calculate Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onCalculate,
              icon: const Icon(Icons.calculate),
              label: const Text("Calculate Risk"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderInput extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final IconData icon;
  final Color color;

  const _SliderInput({
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "${value.toStringAsFixed(0)} $unit",
                style: textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _ResultSection extends StatelessWidget {
  final String? riskLevel;
  final Color? riskColor;

  const _ResultSection({
    this.riskLevel,
    this.riskColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(32),
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
        children: [
          Icon(
            Icons.local_fire_department,
            size: 80,
            color: riskColor ?? AppColors.grey,
          ),
          const SizedBox(height: 24),
          Text(
            "Risk Assessment",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (riskLevel != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: riskColor!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: riskColor!, width: 2),
              ),
              child: Text(
                riskLevel!,
                style: textTheme.headlineMedium?.copyWith(
                  color: riskColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _getRiskRecommendation(),
          ] else ...[
            Text(
              "Set parameters and calculate to see risk level",
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _getRiskRecommendation() {
    String recommendation;
    IconData icon;

    switch (riskLevel) {
      case 'Low Risk':
        recommendation = "Conditions are favorable. Regular monitoring recommended.";
        icon = Icons.check_circle;
        break;
      case 'Moderate Risk':
        recommendation = "Exercise caution. Avoid open fires and monitor conditions.";
        icon = Icons.warning_amber;
        break;
      case 'High Risk':
        recommendation = "High fire danger. No burning. Stay alert for fire warnings.";
        icon = Icons.error_outline;
        break;
      case 'Extreme Risk':
        recommendation = "Extreme fire danger! Total fire ban. Evacuate if instructed.";
        icon = Icons.dangerous;
        break;
      default:
        recommendation = "";
        icon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.silver,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: riskColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommendation,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.dGrey,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}