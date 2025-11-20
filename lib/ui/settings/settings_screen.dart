import 'package:betclictactoe/theme/colors.dart';
import 'package:betclictactoe/ui/shared/widgets/app_button.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:go_router/go_router.dart';

import 'custom_name_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSettings,
      body: SingleChildScrollView(
        child: Column(
          spacing: 60,
          children: [
            _gap,
            const Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1,
              ),
            ),
            _gap,
            const _NameChangeLine('Name'),
            _SettingsLine(
              'Sound FX',
              // TODO: : Get value from notifier
              Icon(true ? Icons.graphic_eq : Icons.volume_off),
              onSelected: () {
                // TODO: Call notifier
              },
            ),
            _SettingsLine(
              'Music',
              // TODO: : Get value from notifier
              Icon(true ? Icons.music_note : Icons.music_off),
              onSelected: () {
                // TODO: Call notifier
              },
            ),
            _gap,
            const Text('Music by Mr Smith'),
            _gap,
            AppButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
            const Spacer(),
            Text(
              'John', // TODO : Get value from notifier
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
