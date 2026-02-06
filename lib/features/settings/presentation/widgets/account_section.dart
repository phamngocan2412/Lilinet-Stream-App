import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/widgets/auth_dialog.dart';
import '../../../auth/presentation/widgets/update_profile_dialog.dart';
import '../../../auth/presentation/widgets/change_password_dialog.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback onDeleteAccount;

  const AccountSection({super.key, required this.onDeleteAccount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (state is Authenticated) ...[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: state.user.avatarUrl != null
                      ? NetworkImage(state.user.avatarUrl!)
                      : null,
                  child: state.user.avatarUrl == null
                      ? Text(state.user.email[0].toUpperCase())
                      : null,
                ),
                title: Text(
                  state.user.displayName ?? state.user.email.split('@')[0],
                ),
                subtitle: Text(state.user.email),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    UpdateProfileDialog.show(
                      context,
                      displayName: state.user.displayName,
                      avatarUrl: state.user.avatarUrl,
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  ChangePasswordDialog.show(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () {
                  context.read<AuthBloc>().add(const SignOutRequested());
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: onDeleteAccount,
              ),
            ] else
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Sign In / Sign Up'),
                subtitle: const Text('Sync favorites across devices'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AuthDialog(),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
