import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_module/pigeons/pigeon_host_api.g.dart';
import 'package:flutter_module/pigeons/task_flutter_api_impl.dart';
import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final hostApi = TaskHostApi();
    final items = useState<List<Item>>([]);

    void reloadItems() async {
      items.value = await hostApi.getItems();
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
          SliverAppBar.large(title: const Text('TODO List')),
          SliverList.builder(
            itemBuilder: (context, index) {
              final item = items.value[index];
              return ListTile(
                title: Text(item.title),
                trailing: IconButton(
                  onPressed: () {
                    hostApi.toggleFavorite(item.id, !item.isFavorite);
                    hostApi.updateItemsIfNeeded();
                  },
                  icon: Icon(
                    item.isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                  ),
                ),
              );
            },
            itemCount: items.value.length,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => hostApi.toggleShowAddSheet(),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
