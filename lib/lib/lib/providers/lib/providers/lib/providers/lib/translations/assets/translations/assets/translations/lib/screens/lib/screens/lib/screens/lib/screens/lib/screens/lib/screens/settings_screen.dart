import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/auth_provider.dart';
import '../translations/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // Profile Section
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
                  child: const Icon(Icons.person, size: 40, color: Color(0xFF6C63FF)),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Student Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '+91 9876543210',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Dark Mode
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: Text(l10n.darkMode),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).setTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
            },
          ),

          // Language
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locale.languageCode == 'hi' ? 'हिन्दी' : 'English',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
            onTap: () {
              _showLanguagePicker(context, ref);
            },
          ),

          const Divider(),

          // About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Text('v1.0.0', style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Rate App'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share App'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () {},
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              l10n.logout,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Language / भाषा चुनें'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Locale>(
              title: const Text('English'),
              value: const Locale('en'),
              groupValue: ref.read(localeProvider),
              onChanged: (v) {
                ref.read(localeProvider.notifier).setLocale(v!);
                Navigator.pop(ctx);
              },
            ),
            RadioListTile<Locale>(
              title: const Text('हिन्दी'),
              value: const Locale('hi'),
              groupValue: ref.read(localeProvider),
              onChanged: (v) {
                ref.read(localeProvider.notifier).setLocale(v!);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}
