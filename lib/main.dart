import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:todolist/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
    'android': 'ca-app-pub-5649618914515561/1789878792',
    }
    : {
     'android': 'ca-app-pub-3940256099942544/6300978111',
    };

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      },
      child: const MaterialApp(
        home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Hello flutter!'),
          // ),
          body: HomeScreen(),
        ),
      ),
    );
  }
}
