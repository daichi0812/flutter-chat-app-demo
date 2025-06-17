import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";

import "user_state.dart";

final userProvider = StateProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});

final postsQueryProvider = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance
      .collection("posts")
      .orderBy("date")
      .snapshots();
});

class ChatPage extends ConsumerWidget {
  // コンストラクタでUserオブジェクトを受け取る
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    final User user = ref.watch(userProvider)!;
    final AsyncValue<QuerySnapshot> asyncPostsQuery = ref.watch(
      postsQueryProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("チャットルーム"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              // ログアウト処理
              // 内部で保持しているログイン情報などが初期化される
              await FirebaseAuth.instance.signOut();
              // ログイン画面に遷移 + チャット画面を破棄
              if (!context.mounted) return;
              context.go("/login");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("ログイン情報: ${user.email}"),
          ),
          Expanded(
            // StreamProviderから受け取った値は、 .when() で状態に応じて出し分けできる
            child: asyncPostsQuery.when(
              // 値が取得できたとき
              data: (QuerySnapshot query) {
                return ListView(
                  children: query.docs.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document["text"]),
                        subtitle: Text(document["email"]),
                        trailing: document["email"] == user.email
                            ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  // 投稿メッセージのドキュメントを削除
                                  await FirebaseFirestore.instance
                                      .collection("posts")
                                      .doc(document.id)
                                      .delete();
                                },
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                );
              },
              // 値が読み込み中の時
              loading: () {
                return Center(child: Text("読み込み中..."));
              },
              // 値の取得に失敗した時
              error: (e, stackTrace) {
                return Center(child: Text(e.toString()));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.push("/add-post", extra: user);
        },
      ),
    );
  }
}
