import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeons/pigeon_host_api.g.dart',
    dartOptions: DartOptions(),
    swiftOut: '../App/AddToAppSample/Flutter/PigeonHostApi.swift',
    swiftOptions: SwiftOptions(),
  ),
)
class Item {
  Item({
    required this.id,
    required this.title,
    this.isDone = false,
    this.isFavorite = false,
  });

  final int id;
  final String title;
  final bool isDone;
  final bool isFavorite;
}

@HostApi()
abstract class TaskHostApi {
  @async
  List<Item> getItems();

  bool getIsFiltered();

  void toggleShowAddSheet();

  @SwiftFunction('goToDetail(id:)')
  void goToDetail(int id);

  @SwiftFunction('toggleFavorite(id:isFavorite:)')
  void toggleFavorite(int id, bool isFavorite);

  @SwiftFunction('toggleDone(id:isDone:)')
  void toggleDone(int id, bool isDone);
}
