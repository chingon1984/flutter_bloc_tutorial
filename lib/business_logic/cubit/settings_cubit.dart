import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(appNotifications: false, emailNotifications: false));

  void toggleAppNotifications(bool value) {
      emit(state.copyWith(appNotifications: value));
  }

  void toggleEmailNotifications(bool value) {
    emit(state.copyWith(emailNotifications: value));
  }
}
