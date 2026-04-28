import 'package:book_worm/screens/settings_pages/export.dart';
import 'package:book_worm/screens/settings_pages/help.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  bool _notesEnabled = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() => _notesEnabled = prefs.getBool('notesEnabled') ?? false);
    }
  }

  Future<void> _setNotes(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notesEnabled', value);
    if (mounted) setState(() => _notesEnabled = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: Column(
        children: [
          // App identity header
          Container(
            color: AppTheme.primaryLight,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.menu_book,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      'Din personlige boklogg',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                // Section label
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Text(
                    'INNSTILLINGER',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                // Notes toggle
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SwitchListTile(
                    secondary: const Icon(Icons.notes, color: AppTheme.primary),
                    title: const Text(AppStrings.aktiverStrukturertNotater),
                    value: _notesEnabled,
                    onChanged: _setNotes,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),
                // Section label
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Text(
                    'DATA & HJELP',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                // Data transfer + Help grouped
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        leading: const Icon(Icons.import_export,
                            color: AppTheme.primary),
                        title: const Text(AppStrings.dataTransfer),
                        trailing: const Icon(Icons.chevron_right,
                            color: AppTheme.textSecondary),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DataTransferPage()),
                        ),
                      ),
                      const Divider(indent: 56, endIndent: 0, height: 1),
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                        ),
                        leading: const Icon(Icons.help_outline,
                            color: AppTheme.primary),
                        title: const Text(AppStrings.help),
                        trailing: const Icon(Icons.chevron_right,
                            color: AppTheme.textSecondary),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HelpPage()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Laget av Sander, Mai 2026',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
