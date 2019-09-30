import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Auto Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _wordListView = [];
  final Set<WordPair> _saved = Set();
  final TextStyle _textFont = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add from here...
      appBar: AppBar(
        title: Center(child: Text('Name Auto Generator')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildListView(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _textFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved wordListView'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider(
              color: Colors.black,
            );
          }

          final int index = i ~/ 2;
          if (index >= _wordListView.length) {
            _wordListView.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_wordListView[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaves = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _textFont,
      ),
      trailing: Icon(
        alreadySaves ? Icons.favorite : Icons.favorite_border,
        color: alreadySaves ? Colors.red : Colors.blueGrey,
      ),
      onTap: () {
        setState(() {
          if (alreadySaves) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
