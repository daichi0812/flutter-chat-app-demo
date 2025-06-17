import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:firebase_auth/firebase_auth.dart';

import "user_state.dart";

// ユーザー情報の受け渡しを行うためのProvider
final userProvider = StateProvider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});

// エラー情報の受け渡しを行うためのProvider
// autoDispose をつけることで自動的に値をリセットできる
final infoTextProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

// メールアドレスの受け渡しを行うためのProvider
// autoDispose をつけることで自動的に値をリセットできる
final emailProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

// パスワードの受け渡しを行うためのProvider
// autoDisposeをつけることで自動的に値をリセットできる
final passwordProvider = StateProvider<String>((ref) {
  return "";
});

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    final infoText = ref.watch(infoTextProvider);
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレスを入力
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  // Providerから値を更新
                  ref.read(emailProvider.notifier).state = value;
                },
              ),
              // パスワードを入力
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                onChanged: (String value) {
                  // Providerから値を更新
                  ref.read(passwordProvider.notifier).state = value;
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                // メッセージ表示
                child: Text(infoText),
              ),
              SizedBox(
                width: double.infinity,
                // ユーザー登録ボタン
                child: ElevatedButton(
                  child: Text("ユーザー登録"),
                  onPressed: () async {
                    try {
                      // メール・パスワードでユーザー登録
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ユーザー情報を更新
                      ref.read(userProvider.notifier).state = result.user;
                      // ウィジェットがまだ画面に存在するかチェック
                      if (!context.mounted) return;
                      // ユーザー登録に成功した場合
                      // チャット画面に遷移 + ログイン画面を破棄
                      context.go("/chat", extra: result.user);
                    } catch (e) {
                      if (!context.mounted) return;
                      // ユーザー登録に失敗した場合
                      // Providerから値を更新
                      ref.read(infoTextProvider.notifier).state =
                          "登録に失敗しました: ${e.toString()}";
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                // ログインボタン
                child: OutlinedButton(
                  child: Text("ログイン"),
                  onPressed: () async {
                    try {
                      // ログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ユーザー情報を更新
                      ref.read(userProvider.notifier).state = result.user;
                      // ログインに成功した場合
                      if (!context.mounted) return;
                      // 画面遷移
                      context.go("/chat", extra: result.user);
                    } catch (e) {
                      // ログインに失敗した場合
                      ref.read(infoTextProvider.notifier).state =
                          "ログインに失敗しました: ${e.toString()}";
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
