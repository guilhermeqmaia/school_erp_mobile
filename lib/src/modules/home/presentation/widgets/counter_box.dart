import 'package:flutter/material.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';

class CounterBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final int titleCount;
  final String subtitle;
  final int subtitleCount;
  final VoidCallback onTap;
  const CounterBox({
    Key? key,
    required this.icon,
    required this.title,
    required this.titleCount,
    required this.subtitle,
    required this.subtitleCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContentBox(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 60,
                color: Colors.orange,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$titleCount $title",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$subtitleCount $subtitle",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
