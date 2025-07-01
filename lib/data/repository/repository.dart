import 'package:booksapp/data/model/books.dart';

import '../source/source.dart';

abstract interface class Repository {
  Future<List<Book>?> loadData();
}

class DefaultRepository implements Repository {

  final _remoteDataSource = RemoteDataSource();
  final _localDataSource = LocalDataSource();

  @override
  Future<List<Book>?> loadData() async {
    List<Book> books = [];
    await _remoteDataSource.loadData().then((remoteBook){
      if (remoteBook == null) {
        _localDataSource.loadData().then((localBook) {
          if (localBook != null) {
            books.addAll(localBook);
          }
        });
      } else {
        books.addAll(remoteBook);
      }
    });
    return books;
  }
}