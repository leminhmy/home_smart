import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtobe_demo/repositories/home_room_repo.dart';
import 'package:youtobe_demo/repositories/member_repo.dart';
import 'package:youtobe_demo/repositories/weather_repo.dart';
import 'package:youtobe_demo/screen/home/bloc/home_bloc.dart';
import 'package:youtobe_demo/screen/home/home_screen.dart';
import 'package:youtobe_demo/services/boredService.dart';
import 'package:youtobe_demo/services/connectivityService.dart';

import 'home/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
            RepositoryProvider(create: (context) => HomeRoomRepo()),
            RepositoryProvider(create: (context) => MemberRepo()),
            RepositoryProvider(create: (context) => WeatherRepo()),
            RepositoryProvider(create: (context) => BoredService()),
            RepositoryProvider(create: (context) => ConnectivityService()),
        ],
          child: HomeScreen()));

  }
}

