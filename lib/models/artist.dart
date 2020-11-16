class Artist {
  String id;
  String name;
  int votes;

  Artist({this.id, this.name, this.votes});

//factory constructor creates a new instance of Artist class
  factory Artist.fromMap(Map<String, dynamic> obj) =>
      Artist(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
