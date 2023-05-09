import 'package:bloc_tutorial/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/ui/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/internet_cubit.dart';

void main() {
  runApp(
      MyApp(
          AppRouter(),
          Connectivity()
      )
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter;
  final Connectivity _connectivity;

  const MyApp(this._appRouter, this._connectivity, {super.key});


  @override
  Widget build(BuildContext context) {
    // provided Counter Cubit globally
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(_connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
