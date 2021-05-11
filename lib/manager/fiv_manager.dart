import 'package:hive/hive.dart';

const favKey = "fav_coin";

class FivManager {
  static final FivManager _instance = FivManager._internal();
  final Box<String> fivStorageBox = Hive.box<String>(favKey);

  factory FivManager() {
    return _instance;
  }

  FivManager._internal();

  void toggleFiv({
    required String id,
  }) {
    if (fivStorageBox.get(id) == null) {
      fivStorageBox.put(id, id);
    } else {
      fivStorageBox.delete(id);
    }
  }

  bool isFiv({
    required String id,
  }) {
    return (fivStorageBox.get(id) != null);
  }

  List<String> getAll() {
    return fivStorageBox.values.toList();
  }
}
