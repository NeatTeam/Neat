import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/role_provider.dart';
import 'screens/role_selection_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cleaner_profile_screen.dart';
import 'utils/constants.dart';
import 'utils/sample_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoleProvider(),
      child: MaterialApp(
        title: 'Neat Cleaning',
        theme: AppTheme.darkTheme,
        home: const RoleSelectionScreen(),
        routes: {
          '/home': (context) => HomeScreen(
            services: SampleData.services,
            promotions: SampleData.promotions,
          ),
          '/cleaner': (context) => CleanerProfileScreen(
            profile: SampleData.cleanerProfile,
          ),
        },
      ),
    );
  }
}
