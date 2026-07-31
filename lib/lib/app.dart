import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/student_dashboard.dart';
import 'screens/course_list_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/video_player_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/auth_provider.dart';
import 'translations/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers se values read karo
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'EdTech Pro',
      debugShowCheckedModeBanner: false,
      
      // Theme - Light aur Dark dono support
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF6C63FF),
              width: 2,
            ),
          ),
        ),
      ),
      
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardTheme: CardTheme(
          elevation: 0,
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      
      themeMode: themeMode,
      
      // Language support
      locale: locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // App ki starting screen
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  // Routing - har screen ka rasta
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(const SplashScreen());
      case '/login':
        return _buildRoute(const LoginScreen());
      case '/otp':
        final phone = settings.arguments as String;
        return _buildRoute(OTPScreen(phoneNumber: phone));
      case '/role-select':
        return _buildRoute(const RoleSelectionScreen());
      case '/dashboard':
        return _buildRoute(const StudentDashboard());
      case '/courses':
        return _buildRoute(const CourseListScreen());
      case '/course-detail':
        final courseId = settings.arguments as String;
        return _buildRoute(CourseDetailScreen(courseId: courseId));
      case '/video':
        final data = settings.arguments as Map<String, dynamic>;
        return _buildRoute(VideoPlayerScreen(
          videoUrl: data['url'] as String,
          lessonTitle: data['title'] as String,
        ));
      case '/quiz':
        return _buildRoute(const QuizScreen());
      case '/settings':
        return _buildRoute(const SettingsScreen());
      default:
        return _buildRoute(const SplashScreen());
    }
  }

  // Smooth animation ke saath screen change
  PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
