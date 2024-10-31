import 'package:final_project/core/enums/status_state.dart';
import 'package:final_project/features/auth/login/widgets/loading_overlay.dart';
import 'package:final_project/features/profile/data/remote_data_source/account_firestore_data_source.dart';
import 'package:final_project/features/profile/data/repositories/account_repository.dart';
import 'package:final_project/features/profile/presentation/avatar_and_username_section.dart';
import 'package:final_project/features/profile/presentation/logic_holders/bloc/account_info_bloc.dart';
import 'package:final_project/features/profile/presentation/settings_content.dart';
import 'package:final_project/features/profile/presentation/widgets/custom_title_and_content_section.dart';
import 'package:final_project/features/profile/presentation/widgets/information_content.dart';
import 'package:final_project/l10n/generated/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider<AccountInfoBloc>(
      create: (context) => AccountInfoBloc(AccountRepositoryImpl(
          remoteDatasource: AccountFirestoreDataSourceImpl()))
        ..add(FetchAccountInfo()),
      child: BlocBuilder<AccountInfoBloc, AccountInfoState>(
        builder: (context, state) {
          final isLoading = state.status == StatusState.loading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xff1B2332),
                  title: Text(
                    l10n.profile_app_bar_title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacementNamed('/');
                          }
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ],
                ),
                body: BlocListener<AccountInfoBloc, AccountInfoState>(
                  listener: (context, state) {
                    final statusMsg = state.successMsg;
                    if (statusMsg != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(statusMsg)));
                    }
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: const Color(0xff181F2B),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const AvatarAndUsernameSection(),
                            const SizedBox(
                              height: 38,
                            ),
                            CustomTitleAndContentSection(
                                title: l10n.profile_app_bar_title,
                                content: const InformationContent()),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomTitleAndContentSection(
                                title: l10n.settings,
                                content: const SettingsContent()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading) const LoadingOverylay()
            ],
          );
        },
      ),
    );
  }
}
