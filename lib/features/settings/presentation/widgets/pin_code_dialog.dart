import 'package:flutter/material.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

class PinCodeDialog extends StatefulWidget {
  final bool isSettingPin; // true = set/change pin, false = verify pin
  final String? currentPin; // Required if verifying

  const PinCodeDialog({super.key, this.isSettingPin = false, this.currentPin});

  static Future<bool?> show(
    BuildContext context, {
    bool isSettingPin = false,
    String? currentPin,
  }) {
    return showDialog<bool>(
      context: context,
      useRootNavigator: true, // Show above miniplayer
      barrierDismissible: false,
      builder: (context) =>
          PinCodeDialog(isSettingPin: isSettingPin, currentPin: currentPin),
    );
  }

  static Future<String?> showSetPin(BuildContext context) {
    return showDialog<String>(
      context: context,
      useRootNavigator: true, // Show above miniplayer
      barrierDismissible: false,
      builder: (context) => const PinCodeDialog(isSettingPin: true),
    );
  }

  @override
  State<PinCodeDialog> createState() => _PinCodeDialogState();
}

class _PinCodeDialogState extends State<PinCodeDialog> {
  final _pinController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onSubmit(String value) {
    final l10n = AppLocalizations.of(context)!;
    if (value.length != 4) {
      setState(() {
        _errorMessage = l10n.pinMustBe4Digits;
        _pinController.clear();
      });
      return;
    }

    if (widget.isSettingPin) {
      // Return the new PIN
      Navigator.pop(context, value);
    } else {
      // Verify PIN
      if (value == widget.currentPin) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          _errorMessage = l10n.incorrectPin;
          _pinController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final title = widget.isSettingPin ? l10n.setPinTitle : l10n.enterPinTitle;
    final instruction = widget.isSettingPin
        ? l10n.setPinInstruction
        : l10n.enterPinInstruction;

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(instruction),
          const SizedBox(height: 16),
          TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.length == 4) {
                _onSubmit(value);
              }
            },
          ),
          if (_errorMessage.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _errorMessage,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }
}
