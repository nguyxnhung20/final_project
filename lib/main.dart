import 'package:final_project/core/common/presentation/blocs/global_info_bloc/global_info_bloc.dart';
import 'package:final_project/core/services/injection_container.dart';
import 'package:final_project/core/theme/my_theme.dart';
import 'package:final_project/features/auth/login/login_screen.dart';
import 'package:final_project/features/home/presentation/home_screen.dart';
import 'package:final_project/features/profile/presentation/profile_screen.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/forgot_password/forgot_password_screen.dart';
import 'package:final_project/l10n/generated/app_localizations.dart';
import 'package:final_project/not_found_page/not_found_page.dart';
import 'package:final_project/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalInfoBloc>(
      create: (_) => GlobalInfoBloc(getIt())..add(GetGlobalInfo()),
      child: BlocBuilder<GlobalInfoBloc, GlobalInfoState>(
        builder: (context, state) {
          return MaterialApp(
            theme: MyTheme.darkTheme(),
            locale: state.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode ==
                    deviceLocale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(builder: (_) => const LoginScreen());
                case 'home':
                  return MaterialPageRoute(builder: (_) => const HomeScreen());
                case 'forgot-password':
                  return MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen());
                case 'profile':
                  return MaterialPageRoute(
                      builder: (_) => const ProfileScreen());
                default:
                  return MaterialPageRoute(
                      builder: (_) => const NotFoundPage());
              }
            },
            home: const RootPage(),
          );
        },
      ),
    );
  }
}

// NowPlayingMoviesScreen()
