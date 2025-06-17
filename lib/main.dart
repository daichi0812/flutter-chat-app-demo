import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // flutterfire configureで自動生成されたファイル

import "login_page.dart";
import "chat_page.dart";
import "add_post_page.dart";

// GoRouterの定義はmain.dartに残すのが一般的
final GoRouter _router = GoRouter(
  initialLocation: "/login",
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: "/chat",
      builder: (BuildContext context, GoRouterState state) {
        return ChatPage();
      },
    ),
    GoRoute(
      path: "/add-post",
      builder: (BuildContext context, GoRouterState state) {
        return AddPostPage();
      },
    ),
  ],
);

void main() async {
  // Flutterの初期化処理を保証する
  WidgetsFlutterBinding.ensureInitialized();
  // Firebaseを初期化する
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    // Riverpodでデータを受け渡しできる状態にする
    ProviderScope(child: const ChatApp()),
  );
}

class ChatApp extends StatelessWidget {
  // コンストラクタ
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // アプリ名
      title: "ChatApp",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routerConfig: _router,
    );
  }
}
