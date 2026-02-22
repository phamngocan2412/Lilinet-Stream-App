import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../core/widgets/loading_indicator.dart';
import 'password_reset_dialog.dart';

class AuthDialog extends StatefulWidget {
  final VoidCallback? onLoginSuccess;

  const AuthDialog({super.key, this.onLoginSuccess});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool _isLogin = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!context.mounted) return;

        if (state is Authenticated) {
          Navigator.pop(context);
          widget.onLoginSuccess?.call();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.welcomeUser(state.user.displayName ?? state.user.email),
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isLogin ? l10n.welcomeBack : l10n.createAccount,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => setState(() => _isLogin = true),
                          child: Text(
                            l10n.login,
                            style: TextStyle(
                              fontWeight: _isLogin ? FontWeight.bold : null,
                              decoration: _isLogin
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                        ),
                        const Text('|'),
                        TextButton(
                          onPressed: () => setState(() => _isLogin = false),
                          child: Text(
                            l10n.signUp,
                            style: TextStyle(
                              fontWeight: !_isLogin ? FontWeight.bold : null,
                              decoration: !_isLogin
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _usernameController,
                      maxLength: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9_.]'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: l10n.username,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                        counterText: "",
                      ),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.enterUsername;
                        }
                        if (value.length < 3) {
                          return l10n.usernameMinLength;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      maxLength: 100,
                      decoration: InputDecoration(
                        labelText: l10n.password,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        counterText: "",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscured,
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.enterPassword;
                        }
                        // Only enforce length on registration to avoid blocking legacy users
                        if (!_isLogin && value.length < 8) {
                          return l10n.passwordMinLength;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLoading ? null : _handleSubmit,
                        child: isLoading
                            ? const LoadingIndicator(
                                size: 20,
                                color: Colors.white,
                              )
                            : Text(_isLogin ? l10n.login : l10n.signUp),
                      ),
                    ),
                    if (_isLogin) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                Navigator.pop(context);
                                PasswordResetDialog.show(context);
                              },
                        child: Text(l10n.forgotPassword),
                      ),
                    ],
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              Navigator.pop(context);
                            },
                      child: Text(l10n.cancel),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthSubmitted(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          isLogin: _isLogin,
        ),
      );
    }
  }
}
