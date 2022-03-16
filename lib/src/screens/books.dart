import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/book_list.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Popular books')),
        body: BookList(
          books: libraryInstance.popularBooks,
          onTap: _handleBookTapped,
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleBookTapped(Book book) {
    _routeState.go('/book/${book.id}');
  }
}
