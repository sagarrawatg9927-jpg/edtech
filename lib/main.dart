import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

void main() async {
  // Yeh 3 lines zaroori hain - app start hone se pehle
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase start karo
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      appId: 'YOUR_APP_ID',
      messagingSenderId: 'YOUR_SENDER_ID',
      projectId: 'YOUR_PROJECT_ID',
    ),
  );
  
  // Local storage start karo
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('downloads');
  
  // App ko run karo
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
