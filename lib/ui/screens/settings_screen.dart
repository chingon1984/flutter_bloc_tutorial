import 'package:bloc_tutorial/business_logic/cubit/settings_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final String title;
  final Color color;

  const SettingsScreen({required this.title, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            final notificationBar = SnackBar(
              duration: const Duration(milliseconds: 700),
              content: Text(
                'App ${state.appNotifications.toString().toUpperCase()}, Email ${state.emailNotifications.toString().toUpperCase()}'
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(notificationBar);
          },
          builder: (context, state) => Column(
                children: [
                  SwitchListTile(
                    value: state.appNotifications,
                    onChanged: (newValue) => context
                        .read<SettingsCubit>()
                        .toggleAppNotifications(newValue),
                    title: const Text('App Notifications'),
                  ),
                  SwitchListTile(
                    value: state.emailNotifications,
                    onChanged: (value) => context
                        .read<SettingsCubit>()
                        .toggleEmailNotifications(value),
                    title: const Text('Email Notifications'),
                  ),
                ],
              )),
    );
  }
}
