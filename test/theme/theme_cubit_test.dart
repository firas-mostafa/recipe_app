import 'package:bloc_test/bloc_test.dart' show blocTest;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_app/helpers/theme/logic/theme_cubit.dart'
    show ThemeCubit, ThemeState;
import 'mock.dart' show MockSharedPreferences, TestCacheHelper;

void main() {
  late MockSharedPreferences mockPrefs;
  late TestCacheHelper testCache;
  setUp(() {
    mockPrefs = MockSharedPreferences();
    testCache = TestCacheHelper(mockPrefs);
    // Stub mockPrefs methods
    when(() => mockPrefs.getInt("theme")).thenReturn(null);
    when(() => mockPrefs.setInt("theme", any())).thenAnswer((_) async => true);
  });
  group("ThemeCubit Tests", () {
    blocTest<ThemeCubit, ThemeState>(
      'Initial state should be system theme',
      build: () => ThemeCubit(cacheHelper: testCache),
      verify: (cubit) => expect(cubit.state, ThemeState(ThemeMode.system)),
    );
    blocTest<ThemeCubit, ThemeState>(
      'Should emit states: dark -> light -> system',
      build: () => ThemeCubit(cacheHelper: testCache),
      act: (cubit) async {
        await cubit.setDark();
        await cubit.setLight();
        await cubit.setSystem();
      },
      expect: () => [
        ThemeState(ThemeMode.dark),
        ThemeState(ThemeMode.light),
        ThemeState(ThemeMode.system),
      ],
    );
    blocTest<ThemeCubit, ThemeState>(
      'Should save to cache when changing theme',
      build: () => ThemeCubit(cacheHelper: testCache),
      act: (cubit) async => await cubit.setDark(),
      verify: (_) {
        verify(() => mockPrefs.setInt('theme', 2)).called(1);
      },
    );
    blocTest<ThemeCubit, ThemeState>(
      'Should load dark theme from cache',
      setUp: () {
        when(() => mockPrefs.getInt('theme')).thenReturn(2);
      },
      build: () => ThemeCubit(cacheHelper: testCache),
      verify: (cubit) {
        expect(cubit.state, ThemeState(ThemeMode.dark));
      },
    );
  });
}
