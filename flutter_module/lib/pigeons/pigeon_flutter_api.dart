import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeons/pigeon_flutter_api.g.dart',
    dartOptions: DartOptions(),
    swiftOut: '../App/AddToAppSample/Flutter/PigeonFlutterApi.swift',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
@FlutterApi()
abstract class TaskFlutterApi {
  void onItemAdded();
}
