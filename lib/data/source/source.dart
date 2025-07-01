import 'dart:convert';

import 'package:booksapp/data/model/books.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Book>?> loadData();
}

class RemoteDataSource implements DataSource{
  @override
  Future<List<Book>?> loadData() async {
    List<Book> books = [];
    final url = 'https://bookapp-c6768.web.app/books.json';
    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    if (reponse.statusCode == 200){
      final bodyContent = utf8.decode(reponse.bodyBytes);
      var BookWrapper = json.decode(bodyContent) as Map;
      var BookList = BookWrapper['books'] as List;
      List<Book> books = BookList.map((book) => Book.fromJson(book)).toList();
      return books;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Book>?> loadData() async  {
    final String reponse = await rootBundle.loadString('assets/books.json');
    final jSonWrapper = json.decode(reponse) as Map;
    final jSonList = jSonWrapper['books'] as List;
    List<Book> books = jSonList.map((book) => Book.fromJson(book)).toList();
    return books;
  }

}