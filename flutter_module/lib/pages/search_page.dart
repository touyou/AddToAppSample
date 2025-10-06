import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_module/components/item_list_tile.dart';
import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';
import 'package:flutter_module/pigeons/pigeon_host_api.g.dart';
import 'package:flutter_module/pigeons/task_flutter_api_impl.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hostApi = TaskHostApi();
    final items = useState<List<Item>>([]);
    final query = useState<String>('');

    void reloadItems() async {
      items.value = (await hostApi.getItems()).where((item) {
        if (query.value.isEmpty) {
          return false;
        }
        return item.title.contains(query.value);
      }).toList();
    }

    void onItemsUpdated() {
      reloadItems();
    }

    void onSearchQueryChanged(String newQuery) {
      query.value = newQuery;
      reloadItems();
    }

    final flutterApi = TaskFlutterApiImpl(
      onItemsUpdatedCallback: onItemsUpdated,
      onSearchQueryChangedCallback: onSearchQueryChanged,
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (query.value.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('検索してください'),
                ),
              ),
            if (query.value.isNotEmpty && items.value.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('「${query.value}」に一致するアイテムはありません'),
                ),
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
      ),
    );
  }
}
