import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/screens/album_detail_screen.dart';
import 'package:projet_spotify_gorouter/screens/album_news_screen.dart';
import 'package:projet_spotify_gorouter/screens/artiste_detail_screen.dart';
import 'package:projet_spotify_gorouter/screens/playlist_screen.dart';
import 'package:projet_spotify_gorouter/screens/search_detail_screen.dart';
import 'package:projet_spotify_gorouter/screens/search_screen.dart';
import 'package:projet_spotify_gorouter/scaffold_with_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final GoRouter router = GoRouter(
  initialLocation: '/a',
  navigatorKey: _rootNavigatorKey,
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text('Page introuvable'),
      ),
    ),
  ),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/a',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AlbumNewsScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'albumdetails/:albumId',
                  builder: (context, state) {
                    final albumId = state.pathParameters['albumId'] ?? '';
                    // final albumTitle = state.pathParameters['albumTitle'] ?? '';
                    // final artistName = state.pathParameters['artistName'] ?? '';
                    // final imageUrl = state.pathParameters['imageUrl'] ?? '';
                    // final releaseDate =
                    //     state.pathParameters['releaseDate'] ?? '';
                    // final totalTracks = 0;
                    return AlbumDetailScreen(
                      albumId: albumId,
                      // albumTitle: albumTitle,
                      // artistName: artistName,
                      // imageUrl: imageUrl,
                      // releaseDate: releaseDate,
                      // totalTracks: totalTracks,
                    );
                  },
                ),
                GoRoute(
                  path: 'artistedetails',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ArtisteDetailScreen();
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'searchdetails',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SearchDetailsScreen();
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              path: '/c',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PlaylistScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
