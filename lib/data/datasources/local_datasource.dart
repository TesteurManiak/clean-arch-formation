import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;
}
