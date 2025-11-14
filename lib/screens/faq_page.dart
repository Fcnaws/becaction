import 'package:flutter/material.dart';
import 'package:ignis/core/theme/app_colors.dart';
import 'package:ignis/core/utils/responsive.dart';
import 'package:ignis/widgets/site_layout.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  final List<FAQItem> faqs = const [
    FAQItem(
      question: "What is IGNIS?",
      answer: "IGNIS is a comprehensive platform for monitoring and analyzing forest fires in Portugal. We provide real-time data, risk assessments, and impact analysis to help communities and authorities respond effectively to fire emergencies.",
    ),
    FAQItem(
      question: "How accurate is the fire risk calculator?",
      answer: "Our risk calculator uses meteorological data, vegetation types, and historical fire patterns to provide accurate risk assessments. While it's a valuable tool for planning, always follow official warnings and guidelines from local authorities.",
    ),
    FAQItem(
      question: "Is the live map updated in real-time?",
      answer: "Yes, our live map is updated every 15 minutes with data from official sources including ICNF (Instituto da Conservação da Natureza e das Florestas) and other monitoring systems.",
    ),
    FAQItem(
      question: "Can I report a fire through IGNIS?",
      answer: "While IGNIS provides monitoring and information, in case of fire emergency, always call 112 first. You can then use our platform to track the fire's progression and access safety information.",
    ),
    FAQItem(
      question: "What should I do if there's a fire near me?",
      answer: "If there's a fire nearby: 1) Call 112 immediately, 2) Follow evacuation orders from authorities, 3) Keep your phone charged and monitor official updates, 4) Have an emergency kit ready, 5) Stay informed through IGNIS and official channels.",
    ),
    FAQItem(
      question: "How can I help prevent forest fires?",
      answer: "You can help prevent fires by: Never leaving fires unattended, properly disposing of cigarettes, avoiding burning during high-risk periods, maintaining clear zones around properties, and reporting suspicious activity to authorities.",
    ),
    FAQItem(
      question: "What data sources does IGNIS use?",
      answer: "IGNIS aggregates data from multiple sources including ICNF, IPMA (Portuguese Institute for Sea and Atmosphere), satellite imagery, and local fire departments to provide comprehensive coverage.",
    ),
    FAQItem(
      question: "Is IGNIS available as a mobile app?",
      answer: "Currently, IGNIS is available as a responsive web application that works on all devices. We're working on dedicated iOS and Android apps that will be available soon.",
    ),
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
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.help_outline,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Frequently Asked Questions",
                  style: textTheme.displayMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Find answers to common questions about IGNIS",
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          // FAQ List
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isLarge ? 800 : double.infinity,
              ),
              child: Column(
                children: faqs
                    .map((faq) => _FAQCard(
                          question: faq.question,
                          answer: faq.answer,
                        ))
                    .toList(),
              ),
            ),
          ),

          const SizedBox(height: 50),

          // Contact Section
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.silver,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.contact_support,
                  size: 48,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  "Still have questions?",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Contact our support team for additional help",
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email),
                  label: const Text("Contact Support"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQCard extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQCard({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<_FAQCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded
              ? AppColors.primary
              : AppColors.greyBlue.withOpacity(0.3),
          width: isExpanded ? 2 : 1,
        ),
        boxShadow: [
          if (isExpanded)
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: InkWell(
        onTap: () => setState(() => isExpanded = !isExpanded),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isExpanded ? AppColors.primary : AppColors.black,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.expand_more,
                      color: isExpanded ? AppColors.primary : AppColors.grey,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    widget.answer,
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: AppColors.dGrey,
                    ),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
  });
}