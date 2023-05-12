import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with HydratedMixin{
  SettingsCubit() : super(SettingsState(appNotifications: false, emailNotifications: false)) {
    hydrate();
  }

  void toggleAppNotifications(bool value) {
      var foo = state.copyWith(appNotifications: value);
      emit(foo);
  }

  void toggleEmailNotifications(bool value) {
    var foo = state.copyWith(emailNotifications: value);
    emit(foo);
  }


  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    addError(Exception('Some shit'), StackTrace.current);
   return state.toMap();
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromMap(json);
  }
}
