import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_list_provider.g.dart';

@riverpod
class ItemList extends _$ItemList {
  @override
  List<String> build() {
    return [];
  }

  void addItem(String item) {
    // spread operator
    state = [...state, item];
  }

  void deleteItem(String item) {
    state = [
      for (final t in state)
        if (t != item) t
    ];
  }
}

@Riverpod(dependencies: [])
String currentItem(CurrentItemRef ref) {
  // Provider는 lazy 로딩이기 때문에 바로 에러를 throw하지 않습니다.
  throw UnimplementedError();
}