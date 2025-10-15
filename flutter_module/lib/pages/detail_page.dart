import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:cupertino_native/components/switch.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.value?.title ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                spacing: 32,
                children: [
                  SizedBox(width: 100, child: Text('Favorite:')),
                  Expanded(
                    child: Center(
                      child: CNSwitch(
                        value: item.value?.isFavorite ?? false,
                        onChanged: (value) {
                          hostApi.toggleFavorite(id, value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 32,
                children: [
                  SizedBox(width: 100, child: Text('Done:')),
                  Expanded(
                    child: Center(
                      child: AdaptiveSwitch(
                        value: item.value?.isDone ?? false,
                        onChanged: (value) {
                          hostApi.toggleDone(id, value);
                        },
                      ),
                    ),
                  ),
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
