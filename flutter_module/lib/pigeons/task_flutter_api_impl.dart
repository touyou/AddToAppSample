import 'package:flutter_module/pigeons/pigeon_flutter_api.g.dart';

class TaskFlutterApiImpl implements TaskFlutterApi {
  TaskFlutterApiImpl({
    void Function()? onItemAddedCallback,
  }) : _onItemAddedCallback = onItemAddedCallback;

  final void Function()? _onItemAddedCallback;

  @override
  void onItemAdded() {
    _onItemAddedCallback?.call();
  }
}
