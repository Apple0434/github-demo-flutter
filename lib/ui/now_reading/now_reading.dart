import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../data/model/books.dart';

// class BookDetailScreen extends StatelessWidget {
//   final Book book;
//
//   const BookDetailScreen({super.key, required this.book});
//
//   Future<String> loadBookContent(String source) async {
//     final uri = Uri.parse(source);
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       return utf8.decode(response.bodyBytes);
//     } else {
//       throw Exception('Không thể tải nội dung sách');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(book.title)),
//       body: FutureBuilder<String>(
//         future: loadBookContent(book.source),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Lỗi: ${snapshot.error}'));
//           } else {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Text(
//                   snapshot.data ?? '',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }


class BookDetailScreen extends StatelessWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  Future<String> loadBookContent (String source) async {
   final uri = Uri.parse(source);
   final response = await http.get(uri);
   if (response.statusCode == 200){
     return utf8.decode(response.bodyBytes);
   } else {
     throw Exception('Không thể tải nội dung sách');
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title),),
      body: FutureBuilder<String>(
          future: loadBookContent(book.source),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError){
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      snapshot.data ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
              ),
              );
            }
          }
      ),
    );
  }
}

// class BookDetailHome extends StatefulWidget {
//   const BookDetailHome({super.key});
//
//   @override
//   State<BookDetailHome> createState() => _BookDetailHomeState();
// }
//
// class _BookDetailHomeState extends State<BookDetailHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Book Detail'),),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Thông tin chi tiết sách',
//             ),
//             const SizedBox(height: 16,),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Quay lại'),
//             ),
//             IconButton(
//                 onPressed: (){},
//                 icon: Icon(Icons.radio)
//             )
//         ]
//         ),
//       ),
//     );
//   }
// }

