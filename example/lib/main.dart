import 'package:flutter/material.dart';
import 'package:flutter_toolkit_easy/flutter_toolkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TestPage());
  }
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    test();

    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text('测试', style: TextStyle(fontSize: 50, color: Colors.black)),
      ),
    );
  }
}

void test() async {
  Log.d('测试Http');

  NetUtil.instance.setHeaders({
    '111':'2222',
    '222':'3333',
  });
  var result = await NetUtil.instance.get(
    'https://www.wanandroid.com/banner/json',
  );

  Log.i(result);
}
