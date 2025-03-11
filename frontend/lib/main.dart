import 'package:flutter/material.dart';
import 'legal.dart';

void main() {
  runApp(const MyApp());
}

// Custom color scheme
class AppColors {
  static const Color platinum = Color(0xFFE4E2E2);
  static const Color darkSpringGreen = Color(0xFF3B6F3F);
  static const Color raisinBlack = Color(0xFF292828);
  static const Color davyGray = Color(0xFF4A4A4A);
  static const Color cadetGray = Color(0xFF9E9E9E);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neat Cleaning Services',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.darkSpringGreen,
          onPrimary: AppColors.platinum,
          secondary: AppColors.davyGray,
          onSecondary: AppColors.platinum,
          error: Colors.red,
          onError: AppColors.platinum,
          background: AppColors.platinum,
          onBackground: AppColors.raisinBlack,
          surface: AppColors.platinum,
          onSurface: AppColors.raisinBlack,
        ),
        scaffoldBackgroundColor: AppColors.platinum,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.raisinBlack),
          bodyMedium: TextStyle(color: AppColors.raisinBlack),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkSpringGreen,
            foregroundColor: AppColors.platinum,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: AppColors.darkSpringGreen,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Neat Cleaning Services',
          style: TextStyle(color: AppColors.platinum),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.platinum,
              AppColors.platinum.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Neat Cleaning Services',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkSpringGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.davyGray.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LegalPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'View Legal Information',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Legal Information',
          style: TextStyle(color: AppColors.platinum),
        ),
        backgroundColor: AppColors.darkSpringGreen,
        iconTheme: const IconThemeData(color: AppColors.platinum),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.platinum,
              AppColors.platinum.withOpacity(0.8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkSpringGreen,
                ),
              ),
              const SizedBox(height: 20),
              _buildSection(
                'Service Agreement',
                'By booking our cleaning services, you agree to these terms and conditions. Our cleaning professionals will perform the services as described in the service description with reasonable care and skill.',
              ),
              _buildSection(
                'Liability',
                'We maintain comprehensive insurance coverage for our cleaning services. However, we are not liable for any pre-existing damage or wear and tear to your property. Please report any concerns within 24 hours of service completion.',
              ),
              _buildSection(
                'Cancellation Policy',
                'We require 24 hours notice for cancellations. Late cancellations may be subject to a cancellation fee of up to 50% of the service cost.',
              ),
              _buildSection(
                'Privacy Policy',
                'We respect your privacy and handle all personal information in accordance with applicable data protection laws. Your information will only be used to provide and improve our services.',
              ),
              _buildSection(
                'Service Guarantee',
                'We strive for 100% customer satisfaction. If you are not satisfied with our service, please contact us within 24 hours and we will rectify any issues at no additional cost.',
              ),
              _buildSection(
                'Payment Terms',
                'Payment is due upon completion of services. We accept major credit cards, digital payments, and bank transfers. Regular cleaning services may be billed on a recurring basis as agreed.',
              ),
              _buildSection(
                'Property Access',
                'You must provide safe and reasonable access to your property at the scheduled time. Please secure any valuable items and inform us of any special instructions or areas to avoid.',
              ),
              _buildSection(
                'Equipment and Supplies',
                'We provide our own professional-grade cleaning equipment and supplies. If you prefer specific products to be used, please discuss this with us beforehand.',
              ),
              const SizedBox(height: 20),
              Text(
                'Last Updated: March 2024',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColors.davyGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.platinum,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.davyGray.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkSpringGreen,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: AppColors.raisinBlack,
            ),
          ),
        ],
      ),
    );
  }
}
