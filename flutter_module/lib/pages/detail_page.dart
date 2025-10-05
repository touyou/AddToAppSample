import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';
import 'package:flutter_module/pigeons/pigeon_host_api.g.dart';
import 'package:flutter_module/pigeons/task_flutter_api_impl.dart';

class DetailPage extends HookWidget {
  const DetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final hostApi = TaskHostApi();
    final item = useState<Item?>(null);

    void reloadItem() async {
      item.value = (await hostApi.getItems()).firstWhere(
        (element) => element.id == id,
      );
    }

    void onItemsUpdated() {
      reloadItem();
    }

    final flutterApi = TaskFlutterApiImpl(
      onItemsUpdatedCallback: onItemsUpdated,
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TaskFlutterApi.setUp(flutterApi);
        reloadItem();
      });
      return () {
        TaskFlutterApi.setUp(null);
      };
    }, const []);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              Text(
                item.value?.title ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                spacing: 8,
                children: [
                  Text('Favorite: ${item.value?.isFavorite}'),
                  Spacer(),
                  Text('Done: ${item.value?.isDone}'),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
