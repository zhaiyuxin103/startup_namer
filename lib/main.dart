import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),

        // 对于每个建议的单词对都会调用一次 itemBuilder，
        // 然后将单词对添加到 ListTile 行中
        // 在偶数行，该函数会为单词对添加一个 ListTile row.
        // 在奇数行，该函数会添加一个分割线的 widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力

        itemBuilder: (BuildContext context, int i) {
          // 在每一列开始之前，添加一个 1 像素高的分割线 widget
          if (i.isOdd) {
            return new Divider();
          }

          // 语法 "i ~/ 2" 表示 i 除以 2，但返回值是整形（向下取整）
          // 比如 i 为：1，2，3，4，5 时，结果为 0，1，1，2，2
          // 这可以计算出 ListView 中减去分割线后的实际单词对数量
          final int index = i ~/ 2;
          // 如果时建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ... 接着再生成 10 个单词对，然后添加再建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
