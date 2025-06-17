import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import "user_state.dart";

final userProvider = StateProvider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});

final messageTextProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

class AddPostPage extends ConsumerWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    final user = ref.watch(userProvider)!;
    final messageText = ref.watch(messageTextProvider);

    return Scaffold(
      appBar: AppBar(title: Text("チャット投稿")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 投稿メッセージ入力
              TextFormField(
                decoration: InputDecoration(labelText: "投稿メッセージ"),
                // 複数行のテキスト入力
                keyboardType: TextInputType.multiline,
                // 最大3行
                maxLines: 3,
                onChanged: (String value) {
                  ref.read(messageTextProvider.notifier).state = value;
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("投稿"),
                  onPressed: () async {
                    final date = DateTime.now()
                        .toLocal()
                        .toIso8601String(); // 現在の日時
                    final email = user.email; // AddPostPage のデータを参照
                    // 投稿メッセージ用ドキュメント作成
                    await FirebaseFirestore.instance
                        .collection("posts") // コレクションID指定
                        .doc() // ドキュメントID自動生成
                        .set({
                          "text": messageText,
                          "email": email,
                          "date": date,
                        });
                    // 一つ前の画面に戻る
                    if (!context.mounted) return;
                    context.pop();
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
