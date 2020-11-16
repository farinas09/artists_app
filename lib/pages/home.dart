import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:artists_names/models/artist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Artist> artists = [
    Artist(id: '1', name: 'Bad Bunny', votes: 5),
    Artist(id: '2', name: 'Luis Miguel', votes: 7),
    Artist(id: '3', name: 'The Weeknd', votes: 4),
    Artist(id: '4', name: 'Post Malone', votes: 5),
    Artist(id: '5', name: 'Drake', votes: 6)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('Artists', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, int index) => _artistTile(artists[index])),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewArtist,
          elevation: 1,
          child: Icon(Icons.add),
        ));
  }

  Widget _artistTile(Artist artist) {
    return Dismissible(
      key: Key(artist.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print(artist.id);
      },
      background: Container(
          padding: EdgeInsets.only(left: 20),
          color: Colors.red,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delete Artist',
                style: TextStyle(color: Colors.white),
              ))),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(artist.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(artist.name),
        trailing: Text('${artist.votes}', style: TextStyle(fontSize: 20)),
        onTap: () => print(artist.name),
      ),
    );
  }

  addNewArtist() {
    final textController = new TextEditingController();

    if (!Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Artist'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addArtist(textController.text))
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('New Artist'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context)),
            CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addArtist(textController.text))
          ],
        );
      },
    );
  }

  void addArtist(String name) {
    if (name.length > 1) {
      //agregar
      this
          .artists
          .add(new Artist(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
