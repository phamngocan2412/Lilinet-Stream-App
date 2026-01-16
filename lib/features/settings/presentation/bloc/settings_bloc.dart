import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/save_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final SaveSettings saveSettings;
  final SettingsRepository repository;

  SettingsBloc({
    required this.getSettings,
    required this.saveSettings,
    required this.repository,
  }) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSettings>(_onUpdateSettings);
    on<ResetSettings>(_onResetSettings);
    on<ClearCache>(_onClearCache);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    final result = await getSettings();
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onUpdateSettings(
    UpdateSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsSaving());
    final result = await saveSettings(event.settings);
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsSaved(event.settings)),
    );
  }

  Future<void> _onResetSettings(
    ResetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    final result = await repository.resetSettings();
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => add(LoadSettings()),
    );
  }

  Future<void> _onClearCache(
    ClearCache event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await repository.clearCache();
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        // Reload settings after clearing cache
        add(LoadSettings());
      },
    );
  }
}
