import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_module/components/item_list_tile.dart';
import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';
import 'package:flutter_module/pigeons/pigeon_host_api.g.dart';
import 'package:flutter_module/pigeons/task_flutter_api_impl.dart';

class FavoritesPage extends HookWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hostApi = TaskHostApi();
    final items = useState<List<Item>>([]);

    void reloadItems() async {
      items.value = (await hostApi.getItems())
          .where((item) => item.isFavorite)
          .toList();
    }

    void onItemsUpdated() {
      reloadItems();
    }

    final flutterApi = TaskFlutterApiImpl(
      onItemsUpdatedCallback: onItemsUpdated,
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TaskFlutterApi.setUp(flutterApi);
        reloadItems();
      });
      return () {
        TaskFlutterApi.setUp(null);
      };
    }, const []);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Favorites'),
            automaticallyImplyLeading: false,
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              final item = items.value[index];
              return ItemListTile(item: item, hostApi: hostApi);
            },
            itemCount: items.value.length,
          ),
        ],
      ),
    );
  }
}
