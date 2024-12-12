
import 'package:flutter/material.dart';
import 'package:lotto/widgets/SettingsScreen/BugWidget.dart';
import 'package:lotto/widgets/SettingsScreen/FeatureWidget.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        const SettingsSection(
          title: Text('설정', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
          tiles: <SettingsTile>[],
        ),
        SettingsSection(
          title: const Text('사용자 피드백', style: TextStyle(color: Colors.grey),),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              onPressed: (context){openModal("기능 제안", FeatureWidget() , context);},
              leading: const Icon(Icons.feedback_outlined),
              title: const Text('기능 제안'),
              value: const Text('앱의 기능, 디자인, 사용자 경험에 대한 개선.'),
            ),
            SettingsTile.navigation(
              onPressed: (context){openModal("버그 신고", BugWidget() , context);},
              leading: const Icon(Icons.report_problem_outlined),
              title: const Text('버그 신고'),
              value: const Text('앱 내에서 발생하는 오류 또는 문제.'),
            ),

          ],
        ),
        SettingsSection(
          title: const Text('일반', style: TextStyle(color: Colors.grey),),
          tiles: <SettingsTile>[
            // SettingsTile.navigation(
            //   onPressed: (context){print("asdf");},
            //   leading: const Icon(Icons.thumb_up_alt_outlined),
            //   title: const Text('리뷰 남기기'),
            //   value: const Text('앱을 평가해주세요'),
            // ),
            SettingsTile.navigation(
              leading: const Icon(Icons.info_outline),
              title: const Text('앱 버전'),
              value: const Text('1.0.0'),
            ),
            // SettingsTile.switchTile(
            //   onToggle: (value) {},
            //   initialValue: true,
            //   leading: const Icon(Icons.format_paint),
            //   title: const Text('Enable custom theme'),
            // ),
          ],
        ),
      ],
    );
  }
}

void openModal(title, Widget Child, context, ){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Child,
              ],
            ),
          ),
        ),
      );
    },
  );
}
