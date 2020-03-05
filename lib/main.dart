import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_name_generator2/model/FavoriteModel.dart';
import 'package:startup_name_generator2/model/NamesModel.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => FavoriteModel()),
        ChangeNotifierProvider(create: (BuildContext context) => NamesModel()),
      ],
      child: MaterialApp(
        title: 'Provider 연습용 앱',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHome(title: 'Compay names U may like'),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  final String title;

  MyHome({Key key, this.title}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
//          TODO: AppBar 높이 조정. 제목을 높이를 좀 더 작게 조정
          bottom: TabBar(tabs: [
            Icon(Icons.list),
            Icon(Icons.favorite_border),
            Icon(Icons.info_outline),
          ]),
        ),
        body: TabBarView(children: [
          Tab1Page(),
          Tab2Page(),
          Center(child: Text('Flutter is awesome!')),
        ]),
      ),
    );
  }
}

class Tab1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _namesModel = Provider.of<NamesModel>(context);
    var _favoriteModel = Provider.of<FavoriteModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          padding: EdgeInsets.all(10.0),
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('생성 갯수: ${_namesModel.getCount()}'),
              Text('선택 갯수: ${_favoriteModel.getCount() ?? 0}'),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) {
                if (index.isOdd) return Divider();

                var no = index ~/ 2;
                var name = _namesModel.getName(no);

                return _buildItem(no, name, context);
              }),
        ),
      ],
    );
  }

  Widget _buildItem(int index, String name, BuildContext context) {
    var _favoriteModel = Provider.of<FavoriteModel>(context);

    return ListTile(
      leading: Text('${index + 1}'),
      title: Text(name),
      trailing:
          Icon(_favoriteModel.isFavorite(name) ? Icons.favorite : Icons.favorite_border, color: Colors.pinkAccent),
      onTap: () {
        print('User selected $name');
        _favoriteModel.toggleFavorite(name);
      },
    );
  }
}


class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _saved = Provider.of<FavoriteModel>(context).saved;

    final Iterable<ListTile> tiles = _saved.map((String name) {
        return ListTile(title: Text(name));
      },
    );

    final List<Widget> divided = ListTile
        .divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return ListView(children: divided);
  }
}

