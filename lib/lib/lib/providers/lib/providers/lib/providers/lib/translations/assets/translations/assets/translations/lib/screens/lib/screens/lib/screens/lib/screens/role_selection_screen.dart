import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../translations/app_localizations.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              Text(
                l10n.selectRole,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Choose how you want to use the app',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 48),

              // Student Card
              _RoleCard(
                icon: Icons.school,
                title: l10n.student,
                subtitle: 'Access courses, take quizzes,\ntrack your progress',
                color: const Color(0xFF6C63FF),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),

              const SizedBox(height: 16),

              // Teacher Card
              _RoleCard(
                icon: Icons.person,
                title: l10n.teacher,
                subtitle: 'Create courses, manage students,\nhost live classes',
                color: const Color(0xFFFF6584),
                onTap: () {
                  // Teacher dashboard
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),

              const SizedBox(height: 16),

              // Parent Card
              _RoleCard(
                icon: Icons.family_restroom,
                title: l10n.parent,
                subtitle: 'Monitor your child\'s progress,\nattendance & fees',
                color: const Color(0xFF4CAF50),
                onTap: () {
                  // Parent dashboard
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
