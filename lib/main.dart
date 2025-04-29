import 'package:flutter/material.dart';
final ValueNotifier<bool> isDarkMode = ValueNotifier(false);


void main() {
  runApp(BookApp());
}

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkModeEnabled, _) {
        return MaterialApp(
          title: 'App Đọc Sách',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.white,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
          ),
          themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LibraryPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Đọc Sách',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> books = [
    'Dế Mèn Phiêu Lưu Ký',
    'Harry Potter và Hòn Đá Phù Thủy',
    'Tuổi Trẻ Đáng Giá Bao Nhiêu',
    'Đắc Nhân Tâm',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            leading: Icon(Icons.menu_book, color: Colors.deepPurple),
            title: Text(
              books[index],
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Tác giả: Tác giả số ${index + 1}'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(bookTitle: books[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BookDetailPage extends StatelessWidget {
  final String bookTitle;

  const BookDetailPage({Key? key, required this.bookTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: Text(
            'Nội dung chi tiết của sách "$bookTitle" sẽ được hiển thị ở đây.\n\n'
                'Bạn có thể thêm chức năng lật trang, đánh dấu trang, cỡ chữ, màu nền...',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '📖 Thư viện của bạn sẽ hiển thị ở đây',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: SwitchListTile(
            title: Text('Chế độ tối'),
            subtitle: Text('Bật/tắt chế độ Dark Mode'),
            value: isDarkMode.value,
            onChanged: (value) {
              isDarkMode.value = value;
            },
            secondary: Icon(Icons.dark_mode),
          ),
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Thông tin ứng dụng'),
          subtitle: Text('Phiên bản 1.0.0'),
        ),
      ],
    );
  }
}
