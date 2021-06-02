import 'package:mvvm_hotpepper/models/logic.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TopPage(),
    );
  }
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountModel>(
      create: (context) => CountModel(),
      child: AppBody(),
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CountModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text('Flutter Demo Home Page'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PostCode(),
                  CountText(),
                  PostcodeAddress(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: model.increment,
              tooltip: 'Increment',
              child: Icon(Icons.search),
            )));
  }
}

class CountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${Provider.of<CountModel>(context).count}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class PostCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      /// context からModelの値が使える
      '${Provider.of<CountModel>(context).address}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class PostcodeAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      /// context からModelの値が使える
      '${Provider.of<CountModel>(context).strtmp}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
