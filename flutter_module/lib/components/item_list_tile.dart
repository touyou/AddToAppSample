import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/pigeons/pigeon_host_api.g.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({super.key, required this.item, required this.hostApi});

  final Item item;
  final TaskHostApi hostApi;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      enabled: !item.isDone,
      onTap: () {
        hostApi.goToDetail(item.id);
      },
      leading: Checkbox.adaptive(
        value: item.isDone,
        onChanged: (value) {
          hostApi.toggleDone(item.id, value ?? false);
          hostApi.updateItemsIfNeeded();
        },
      ),
      trailing: IconButton(
        onPressed: () {
          hostApi.toggleFavorite(item.id, !item.isFavorite);
          hostApi.updateItemsIfNeeded();
        },
        icon: Icon(
          item.isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        ),
      ),
    );
  }
}
