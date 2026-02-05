import 'package:flutter/material.dart';

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
      barrierDismissible: false,
      builder: (context) =>
          PinCodeDialog(isSettingPin: isSettingPin, currentPin: currentPin),
    );
  }

  static Future<String?> showSetPin(BuildContext context) {
    return showDialog<String>(
      context: context,
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
  String _title = '';
  String _instruction = '';

  @override
  void initState() {
    super.initState();
    if (widget.isSettingPin) {
      _title = 'Set PIN';
      _instruction = 'Enter a 4-digit PIN to secure adult content.';
    } else {
      _title = 'Enter PIN';
      _instruction = 'Enter your PIN to access this feature.';
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onSubmit(String value) {
    if (value.length != 4) {
      setState(() {
        _errorMessage = 'PIN must be 4 digits';
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
          _errorMessage = 'Incorrect PIN';
          _pinController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_instruction),
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
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
