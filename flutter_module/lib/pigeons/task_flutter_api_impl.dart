import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';

class TaskFlutterApiImpl implements TaskFlutterApi {
  TaskFlutterApiImpl({void Function()? onItemsUpdatedCallback})
    : _onItemsUpdatedCallback = onItemsUpdatedCallback;

  final void Function()? _onItemsUpdatedCallback;

  @override
  void onItemsUpdated() {
    _onItemsUpdatedCallback?.call();
  }
}
