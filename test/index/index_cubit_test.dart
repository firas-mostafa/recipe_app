import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart' show blocTest;
import 'package:recipe_app/presentation/main/logic/index_cubit/index_cubit.dart'
    show IndexCubit, IndexState;

void main() {
  group("Test Index Cubit", () {
    IndexCubit? indexCubit;
    setUp(() {
      indexCubit = IndexCubit();
    });
    tearDown(() {
      indexCubit!.close();
    });
    test("the initial State of the index Cubit is 0", () {
      expect(indexCubit!.state, IndexState(0));
    });
    blocTest<IndexCubit, IndexState>(
      'emits the right index when My index is changing.',
      build: () => IndexCubit(),
      act: (indexCubit) {
        indexCubit.changeIndex(1);
        indexCubit.changeIndex(2);
        indexCubit.changeIndex(3);
        indexCubit.changeIndex(0);
      },
      expect: () => <IndexState>[
        IndexState(1),
        IndexState(2),
        IndexState(3),
        IndexState(0),
      ],
    );
  });
}
