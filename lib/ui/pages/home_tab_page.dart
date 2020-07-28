import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:fast_kara/ui/material/ColorDefine.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //Async Function
  Future<List<Songs>> _getListSongs() async {
    var response = await http.get('http://fastkara.herokuapp.com/songbooktest');
    List<Songs> songList = [];

    if(response.statusCode == 200) {
      var songsJsonData = json.decode(response.body);

      for(var songsInfo in songsJsonData) {
        Songs songs = Songs(songsInfo["songid"], songsInfo["title"], songsInfo["singer"], songsInfo["imgurl"], songsInfo["beaturl"], songsInfo["view"]);
        songList.add(songs);
      }
      return songList;
    }
    else{
      //Todo: Show Error Code
      return songList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: const Text('Popular Songs',
            style: TextStyle(
                color: CommonColor.textBaseColor
            )
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: FutureBuilder(
          future: _getListSongs(),
          builder: (BuildContext context, AsyncSnapshot listSong) {
            if(listSong.data == null) {
              return Container (
                child: Center(
                  child: Loading(indicator: BallPulseIndicator(), size: 50.0),
                ),
              );
            }
            else {
              return ListView.builder(
                  itemCount: listSong.data.length,
                  itemBuilder: (BuildContext context, int index) {
                return _listSong(listSong, index);
              });
            }
          },
        ),
      )
    );
  }

  Widget _listSong(AsyncSnapshot snapshot, int index) {
    return SizedBox(
      height: 80,
        child: Card(
            color: CommonColor.backgroundColor,
            margin: EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 60,
                    minHeight: 60,
                    maxWidth: 60,
                    maxHeight: 60,
                  ),
                  child: Image.network(
                    'https://109cdf7de.vws.vegacdn.vn/v1/banner/528.jpg?t=1593536400', //Todo Get image from server
                    fit: BoxFit.fill,
                  )),
              title: Text(snapshot.data[index].title,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(snapshot.data[index].singer,
                style: TextStyle(color: Color.fromRGBO(94, 94, 94, 1.0)),
                textAlign: TextAlign.left,
              ),
              trailing: Wrap(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    color: Colors.white60,
                    onPressed: () {
                      setState(() {
                        // ToDo: Display menu popup
                      });
                    },
                  ),
                ],
              ),
              onTap: () {
                // ToDo: Go to play_song_page
              },
            )
        )
    );
}
}

class Songs{
  final int songId;
  final String title;
  final String singer;
  final String imgUrl;
  final String beatUrl;
  final String view;

  Songs(this.songId, this.title, this.singer, this.imgUrl, this.beatUrl, this.view);

}