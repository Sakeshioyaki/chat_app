import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'configs/app_configs.dart';
import 'configs/app_env_config.dart';

void main() async {
  AppConfigs.env = Environment.prod;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {});
  runApp(const MyApp());
}
