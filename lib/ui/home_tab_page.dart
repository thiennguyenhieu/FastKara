import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<String> items = List<String>.generate(10000, (i) => "Title $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
        title: const Text('Popular Songs',
            style: TextStyle(color: const Color.fromRGBO(255, 218, 159, 1.0))),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: items.length = items.length,
        itemBuilder: (context, index) {
          return Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text('${items[index]}'),
                subtitle: Text('${items[index]}'),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          // Todo: Update icon
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.file_download),
                      onPressed: () {
                        setState(() {
                          // Todo: Update icon
                        });
                      },
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
