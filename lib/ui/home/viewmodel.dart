import 'dart:async';

import 'package:booksapp/data/repository/repository.dart';

import '../../data/model/books.dart';

class ViewModelBook {
  StreamController<List<Book>> bookSteam = StreamController();
  void loadBook() {
    final repository = DefaultRepository();
    repository.loadData().then((value) => bookSteam.add(value!));
  }
}