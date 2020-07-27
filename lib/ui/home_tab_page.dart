import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<String> items =
      List<String>.generate(10000, (i) => "Em Không Sai Chúng Ta Sai");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
        title: const Text('Popular Songs',
            style: TextStyle(color: const Color.fromRGBO(255, 218, 159, 1.0))),
      ),
      backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
      body: ListView.builder(
        itemCount: items.length = items.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: ListTile(
                leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 60,
                      minHeight: 60,
                      maxWidth: 60,
                      maxHeight: 60,
                    ),
                    child: Image.network(
                        'https://109cdf7de.vws.vegacdn.vn/v1/banner/528.jpg?t=1593536400')),
                title: Text('${items[index]}',
                    style: TextStyle(color: Colors.white)),
                subtitle: Text('${items[index]}',
                    style: TextStyle(color: Colors.white70)),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.white70,
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
