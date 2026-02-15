import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveServices{
  static const String _boxName = 'appBox';
  static Box? _box;

  static Future<void> init() async{
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  static Box get box{
    if(_box == null){
      throw Exception("Hive box not initialized. Call HiveService.init()");
    }
    return _box!;
  }

  static bool isFirstTime(){
    return box.get('isFirstTime' , defaultValue: true);
  }

  static Future<void> setFirstTime(bool value) async{
    await box.put('isFirstTime', value);
  }

  static Future<void> clearAll() async{
    await box.clear();
  }


}