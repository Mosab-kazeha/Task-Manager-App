import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt config = GetIt.instance;

setup() {
  config.registerSingleton(const FlutterSecureStorage());
}

writeSecureData(String key, String value) async {
  await config.get<FlutterSecureStorage>().write(key: key, value: value);
}
