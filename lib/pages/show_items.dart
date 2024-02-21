import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../items/item_list_provider.dart';

class ShowItems extends ConsumerWidget {
  const ShowItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemListProvider);

    return ListView(
      children: [
        // collection for-loop
        for (final item in items)
          ProviderScope(
            // 각 child widget에만 유효한 item이라는 value를 return하는 Provider가 있다면,
            // 우리는 그 item값을 EachItem widget에 넘기지 않고도 EachItem widget에서 엑세스할 수가 있습니다.
            // override할 Provider를 리스트업하겠습니다.
            overrides: [currentItemProvider.overrideWithValue(item)],
            child: const EachItem(),
          )
      ],
    );
    // return ListView(
    //   children: [for (final item in items) EachItem(item: item)],
    // );
  }
}

class EachItem extends ConsumerWidget {
  const EachItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItemProvider);
    print('building $item');

    return ListTile(
      title: Text(
        item,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: IconButton(
        onPressed: () {
          ref.read(itemListProvider.notifier).deleteItem(item);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
// class EachItem extends ConsumerWidget {
//   const EachItem({
//     super.key,
//     required this.item,
//   });
//   final String item;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     print('building $item');
//
//     return ListTile(
//       title: Text(
//         item,
//         style: const TextStyle(fontSize: 18.0),
//       ),
//       trailing: IconButton(
//         onPressed: () {
//           ref.read(itemListProvider.notifier).deleteItem(item);
//         },
//         icon: const Icon(Icons.delete),
//       ),
//     );
//   }
// }