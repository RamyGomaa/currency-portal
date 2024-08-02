import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';
import 'core/flavor/flavor_config.dart';
import 'injection_container.dart' as di;

mainGlobal({Flavor flavor = Flavor.prod}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlavorConfig.setInstance(
    instance: FlavorConfig.getFlavorFromEnum(flavor),
  );
  await di.init();
  runApp(const MyApp());
}
