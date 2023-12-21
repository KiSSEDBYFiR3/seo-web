import 'package:seo_web/feature/domain/repository/i_local_repository.dart';
import 'package:uuid/uuid.dart';

Future<String> configureUuid(ILocalAuthRepository repository) async {
  String uuid = await repository.getUuid();
  if (uuid.isEmpty) {
    uuid = const Uuid().v4();
    await repository.setUuid(uuid);
  }
  return uuid;
}
