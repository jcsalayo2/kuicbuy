import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/models/chat_model.dart';
import 'package:kuicbuy/pages/chats/conversation.dart';
import 'package:kuicbuy/pages/home/product_grid.dart';
import 'package:intl/intl.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.chats.length,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Conversation(
                      chat: state.chats[index],
                    ),
                  ),
                );
              },
              child: chatTile(chat: state.chats[index]),
            );
          },
        );
      },
    );
  }

  Widget chatTile({required Chat chat}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
            width: 75,
            child: chat.product != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: ProductImage(
                        image: chat.product!.images.thumbnail,
                        height: 75,
                        width: 75),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.product?.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  (chat.sender == auth.currentUser?.uid
                          ? "You: "
                          : (chat.product?.sellerId == auth.currentUser?.uid
                              ? "Buyer: "
                              : "Seller: ")) +
                      chat.lastMessage,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat('MM/dd/yyyy').format(chat.lastMessageTimestamp),
                style: const TextStyle(fontSize: 10),
              ),
              Text(
                DateFormat('h:mm aa').format(chat.lastMessageTimestamp),
                style: const TextStyle(fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
