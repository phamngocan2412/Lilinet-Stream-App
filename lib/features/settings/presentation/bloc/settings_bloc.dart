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
  }) : super(const SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSettings>(_onUpdateSettings);
    on<ResetSettings>(_onResetSettings);
    on<ClearCache>(_onClearCache);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    final result = await getSettings();
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (settings) => emit(SettingsLoaded(settings: settings)),
    );
  }

  Future<void> _onUpdateSettings(
    UpdateSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsSaving());
    final result = await saveSettings(event.settings);
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (_) => emit(SettingsSaved(settings: event.settings)),
    );
  }

  Future<void> _onResetSettings(
    ResetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    final result = await repository.resetSettings();
    result.fold(
      (failure) => emit(SettingsError(message: failure.message)),
      (_) => add(const LoadSettings()),
    );
  }

  Future<void> _onClearCache(
    ClearCache event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await repository.clearCache();
    result.fold((failure) => emit(SettingsError(message: failure.message)), (
      _,
    ) {
      // Reload settings after clearing cache
      add(const LoadSettings());
    });
  }
}
