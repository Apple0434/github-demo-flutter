  import 'package:booksapp/ui/home/viewmodel.dart';
import 'package:booksapp/ui/now_reading/viewbook.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

  import '../../data/model/books.dart';
  import '../discovery/discovery.dart';
  import '../now_reading/now_reading.dart';
import '../settings/settings.dart';
  import '../user/users.dart';

  class BookApp extends StatelessWidget {
    const BookApp({super.key});

    @override
    Widget build(BuildContext context) {
      return Consumer<ThemeViewModel>(builder: (context, themeVN, child) {
        return MaterialApp(
          title: 'Book App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeVN.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const BookHome(),
          debugShowCheckedModeBanner: false,
        );
      }
      );
    }
  }

  class BookHome extends StatefulWidget {
    const BookHome({super.key});

    @override
    State<BookHome> createState() => _BookHomeState();
  }

  class _BookHomeState extends State<BookHome> {
    final List<Widget> _books = [
      const HomeTab(),
      const DiscoveryTab(),
      const AccountTab(),
      const SettingsTab(),
    ];
    @override
    Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Book App'),),
          child: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home)),
                    BottomNavigationBarItem(icon: Icon(Icons.person)),
                    BottomNavigationBarItem(icon: Icon(Icons.settings)),
                    BottomNavigationBarItem(icon: Icon(Icons.notifications)),
                  ],
              ),
              tabBuilder: (BuildContext context, int index) {
                return _books[index];
              }
          ),
      );
    }
  }

  class HomeTab extends StatelessWidget {
    const HomeTab({super.key});

    @override
    Widget build(BuildContext context) {
      return const HomeTabPage();
    }

  }

  class HomeTabPage extends StatefulWidget {
    const HomeTabPage({super.key});

    @override
    State<HomeTabPage> createState() => _HomeTabPageState();
  }

  class _HomeTabPageState extends State<HomeTabPage> {
    final List<Book> books = [];
    late ViewModelBook _viewModelBook = ViewModelBook();

    @override
    void initState() {
      _viewModelBook = ViewModelBook();
      _viewModelBook.loadBook();
      observerData();
      super.initState();
    }

    @override
    void dispose() {
      _viewModelBook.bookSteam.close();
      super.dispose();
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(body: getbody(),);
    }

    Widget getbody() {
      bool showLoading = books.isEmpty;
      if (showLoading) {
        return getProgressBar();
      } else {
        return getListView();
      }
    }

    Widget getProgressBar() {
      return const Center(child: CircularProgressIndicator());
    }

    ListView getListView() {
      return ListView.separated(
        itemBuilder: (context, position) {
          return getRow(position);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
            endIndent: 24,
            indent: 24,
            color: Colors.grey,
          );
        },
        itemCount: books.length,
        shrinkWrap: true,
      );
    }

    void observerData() {
      _viewModelBook.bookSteam.stream.listen((bookList) {
        setState(() {
          books.addAll(bookList);
        });
      });
    }

    Widget getRow(index) {
      // return Text(books[index].title);
      return _BookSection(parent: this, book: books[index]);

    }


  }



  class _BookSection extends StatelessWidget {
    const _BookSection({super.key, required this.parent, required this.book});
    final _HomeTabPageState parent;
    final Book book;
    @override
    Widget build(BuildContext context) {
      return ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: ClipRect(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/load.png',
              height: 100,
              width: 100,
            image: book.image,
          ),
        ),
        title: Text(book.title),
        subtitle: Text(book.artist),
        trailing: IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_horiz),
        ),
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
             BookDetailScreen(book: book),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.1);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );

            }
          )
          );
        }
        );
    }
  }






