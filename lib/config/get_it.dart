import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt config = GetIt.instance;

setup() {
  config.registerSingleton(const FlutterSecureStorage());
}

writeSecureData(String key, String value) async {
  await config.get<FlutterSecureStorage>().write(key: key, value: value);
}

readSecureData(String key) async {
  String? storage = await config.get<FlutterSecureStorage>().read(key: key);
  if (storage == null) {
    return false;
  } else {
    return true;
  }
}
