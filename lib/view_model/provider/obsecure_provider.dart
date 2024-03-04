import 'package:flutter/cupertino.dart';

class ObsecureProvider with ChangeNotifier{
  bool _ob=false;
  bool get ob=>_ob;
  void obsecure(){
    _ob=!_ob;
    notifyListeners();
  }
}