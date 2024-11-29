import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SettingsList(
        sections: [
          const SettingsSection(
            title: Text('설정', style: TextStyle(fontSize: 24, color: Colors.black),),
            tiles: <SettingsTile>[],
          ),
          SettingsSection(
            title: const Text('기본', style: TextStyle(color: Colors.grey),),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('언어'),
                value: const Text('한국어'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
