import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/blocs/user/user_cubit.dart';
import 'presentation/home_page/home_page.dart';
import 'service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => UserCubit(getRandomUser: sl()),
        child: const MyHomePage(),
      ),
    );
  }
}
