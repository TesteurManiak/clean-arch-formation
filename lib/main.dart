import 'package:flutter/material.dart';

import 'app.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const MyApp());
}
