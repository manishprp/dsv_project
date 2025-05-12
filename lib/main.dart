import 'package:dsv_project/core/local/store_user.dart';
import 'package:dsv_project/presentation/profile_screen/profile_screen.dart';

import 'domain/model/user.dart';
import 'presentation/login_signup/bloc/bloc/loginsignup_bloc.dart';
import 'presentation/profile_screen/bloc/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/login_signup/login_signup_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var user = await StoreRetrieve.retrieveUser();
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginsignupBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: user != null ? ProfileScreen(user: user!) : LoginSignupScreen(),
      ),
    );
  }
}
