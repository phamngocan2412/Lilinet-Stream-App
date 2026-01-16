import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

@lazySingleton
class SaveSettings {
  final SettingsRepository repository;

  SaveSettings(this.repository);

  Future<Either<Failure, void>> call(AppSettings settings) async {
    return await repository.saveSettings(settings);
  }
}
