import 'package:testapp/app/app.dart';
import 'package:testapp/constants/enums.dart';
import 'package:testapp/counter/counter.dart';
import 'package:testapp/login/login.dart';
import 'package:flutter/widgets.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page> pages){
  switch (state) {
    case AppStatus.authenticated:{
      return [CounterPage.page()];
    }
    case AppStatus.unauthenticated:
    default:{
      return [LoginScreen.page()];
    }
    
  }
}