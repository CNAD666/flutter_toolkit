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

    return Container(
      color: Colors.white,
      child: Text('测试', style: TextStyle(fontSize: 300)),
    );
  }
}

void test() async {
  Log.d('测试Http');
  var query = {'return': 'json'};

  NetUtil.instance.init(baseUrl: 'https://api.ixiaowai.cn/');
  var result = await NetUtil.instance.get(
    'api/api.php',
    queryParameters: query,
  );
  Log.i(result);
}
