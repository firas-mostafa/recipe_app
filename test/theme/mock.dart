import 'package:mocktail/mocktail.dart' show Mock;
import 'package:recipe_app/helpers/cache/cache_helper.dart' show CacheHelper;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class MockSharedPreferences extends Mock implements SharedPreferences {}

class TestCacheHelper extends Mock implements CacheHelper {
  final MockSharedPreferences mockPrefs;

  TestCacheHelper(this.mockPrefs);

  @override
  Future<void> init() async {}

  @override
  dynamic getData({required String key}) {
    // FIX: Return int values directly
    return mockPrefs.getInt(key);
  }

  @override
  Future<bool> saveData({required String key, required value}) async {
    // FIX: Properly handle int values
    if (value is int) return mockPrefs.setInt(key, value);
    return false;
  }
}
