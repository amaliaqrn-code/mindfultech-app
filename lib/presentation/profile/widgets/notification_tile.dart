import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF4A90E2),
            child: Icon(icon, color: Colors.white, size: 20),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            time,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
