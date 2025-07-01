class Book {
  Book({
    required this.id,
    required this.title,
    required this.publishing,
    required this.artist,
    required this.source,
    required this.image,
  });

  factory Book.fromJson(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      publishing: map['publishing'] ,
      artist: map['artist'],
      source: map['source'],
      image: map['image'],
    );
  }

   String id;
   String title;
   String publishing;
   String artist;
   String source;
   String image;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Book{id: $id, title: $title, publishing: $publishing, artist: $artist, source: $source, image: $image}';
  }
}
