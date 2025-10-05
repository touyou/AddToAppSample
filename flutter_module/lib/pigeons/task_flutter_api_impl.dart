import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';

class TaskFlutterApiImpl implements TaskFlutterApi {
  TaskFlutterApiImpl({
    void Function()? onItemsUpdatedCallback,
    void Function(String)? onSearchQueryChangedCallback,
  }) : _onItemsUpdatedCallback = onItemsUpdatedCallback,
       _onSearchQueryChangedCallback = onSearchQueryChangedCallback;

  final void Function()? _onItemsUpdatedCallback;
  final void Function(String)? _onSearchQueryChangedCallback;

  @override
  void onItemsUpdated() {
    _onItemsUpdatedCallback?.call();
  }

  @override
  void onSearchQueryChanged(String query) {
    _onSearchQueryChangedCallback?.call(query);
  }
}
