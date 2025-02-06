import 'dart:io';

import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/providers/bloc_providers_list.dart';

import 'DI/injector.dart';
import 'config/http_override.dart';
import 'data/service/dio_base.service.dart';
import 'routes/routes.dart';
import 'utils/constants.dart';

final autoInjector = AutoInjector();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //*---(hiding Re captcha badge)
  GRecaptchaV3.hideBadge();
  //*-----(initializing auto injector)
  autoInjectInitializer();
  //load .env file
  await dotenv.load(fileName: Config.devEnvPath);
  await DioBaseService.init();
  //!warning--------------need to remove before deployment
  HttpOverrides.global = MyHttpOverrides();
  //initialize Dio service
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: blocProviderList,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyRouter.router,
      ),
    );
  }
}
