import 'package:bloc_tutorial/business_logic/cubit/internet_cubit.dart';
import 'package:bloc_tutorial/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/counter_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.wifi) {
                return Text(
                  'Wifi',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.red),
                );
              }

              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.mobile) {
                return Text(
                  'Mobile',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.green),
                );
              }

              return Text(
                'Disconnected',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.grey),
              );
            }),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (newContext, state) {
                if (state.wasIncremented!) {
                  ScaffoldMessenger.of(newContext).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(newContext).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  '${state.counterValue}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),

            // context.watch => rebuilding if one state changes
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.wifi) {
                return Text(
                  'Counter: ${counterState.counterValue}  Internet: wifi',
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              }

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.mobile) {
                return Text(
                  'Counter: ${counterState.counterValue}  Internet: mobile',
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              }

              return Text(
                'Counter: ${counterState.counterValue}  Internet: disconnected',
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }),
            const SizedBox(
              height: 24,
            ),

            // context.select => whenever value is different from past valie , callback is executed
            Builder(
                builder: (context) {
                  final counterValue = context.select((CounterCubit cubit) => cubit.state.counterValue);
                  return Text(
                    'Countervalue: ${counterValue}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }),
            const SizedBox(
              height: 24,
            ),
            // Plus Minus Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => context.read<CounterCubit>().increment(),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<CounterCubit>().decrement(),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),

            // Routing Button
            MaterialButton(
                color: color,
                child: const Text('Go to second screen!'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                })
          ],
        ),
      ),
    );
  }
}
