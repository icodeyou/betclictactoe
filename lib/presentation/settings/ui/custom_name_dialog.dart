import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/settings/notifier/settings_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void showCustomNameDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (_, animation, _) => CustomNameDialog(animation: animation),
  );
}

class CustomNameDialog extends ConsumerStatefulWidget {
  final Animation<double> animation;

  const CustomNameDialog({required this.animation, super.key});

  @override
  ConsumerState<CustomNameDialog> createState() => _CustomNameDialogState();
}

class _CustomNameDialogState extends ConsumerState<CustomNameDialog> {
  final TextEditingController _controller = TextEditingController();

  SettingsNotifier get settingsNotifier =>
      ref.read(settingsNotifierProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        title: const AppText(
          'Change name',
          fontSize: ThemeFontSizes.m,
          textAlign: TextAlign.start,
        ),
        children: [
          Padding(
            padding: ThemeSizes.l.asInsets.horizontalOnly,
            child: TextField(
              controller: _controller,
              autofocus: true,
              maxLength: AppConstants.playerNameMaxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontSize: ThemeFontSizes.l),
              onSubmitted: (value) {
                _onSubmit(context, value);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              _onSubmit(context, _controller.text);
            },
            child: AppText(
              t.settingsScreen.saveButtonLabel,
              fontSize: ThemeFontSizes.m,
              color: ThemeColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit(BuildContext context, String value) async {
    final goRouter = GoRouter.of(context);
    await settingsNotifier.setPlayerName(value);
    goRouter.pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(settingsNotifierProvider);
  }
}
