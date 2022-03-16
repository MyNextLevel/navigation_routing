import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/fade_transition_page.dart';
import 'author_details.dart';
import 'book_details.dart';
import 'scaffold.dart';

class PortfolioNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const PortfolioNavigator({required this.navigatorKey, Key? key})
      : super(key: key);

  @override
  _PortfolioNavigatorState createState() => _PortfolioNavigatorState();
}

class _PortfolioNavigatorState extends State<PortfolioNavigator> {
  final _scaffoldKey = const ValueKey('App scaffold');
  final _workDetailsKey = const ValueKey('Book details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Book? selectedBook;
    if (pathTemplate == '/work/:workId') {
      selectedBook = libraryInstance.allBooks.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['workId']);
    }

    Author? selectedAuthor;
    if (pathTemplate == '/author/:authorId') {
      selectedAuthor = libraryInstance.allAuthors.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['authorId']);
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        if (route.settings is Page &&
            (route.settings as Page).key == _workDetailsKey) {
          routeState.go('/');
        }
        return route.didPop(result);
      },
      pages: [
        ...[
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const BookstoreScaffold(),
          ),
          if (selectedBook != null)
            MaterialPage<void>(
              key: _workDetailsKey,
              child: BookDetailsScreen(book: selectedBook),
            )
        ],
      ],
    );
  }
}
