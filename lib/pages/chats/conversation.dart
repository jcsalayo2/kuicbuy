import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/models/chat_model.dart';
import 'package:kuicbuy/models/message_model.dart';
import 'package:kuicbuy/pages/add_product/add_product.dart';
import 'package:kuicbuy/pages/chats/bloc/conversation_bloc.dart';

class Conversation extends StatefulWidget {
  const Conversation({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  var messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc()
        ..add(ListenToConversation(chatId: widget.chat.id))
        ..add(GetChatDetails(
            chat: widget.chat, uid: auth.currentUser?.uid ?? '')),
      child: Builder(builder: (context) {
        return BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65), // Set this height
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          onPressed: () {
                            context
                                .read<ConversationBloc>()
                                .add(const StopListen());
                            Navigator.of(context).pop();
                          }),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.otherPerson?.fullName ?? '',
                                style: const TextStyle(fontSize: 18)),
                            Text(state.chat?.product?.title ?? '',
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(child: chatList(state.messages)),
                  Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: "Message",
                                controller: messageController,
                                onFieldSubmitted: (message) {
                                  context.read<ConversationBloc>().add(
                                      SendMessage(
                                          message: message,
                                          uid: auth.currentUser?.uid ?? ''));
                                  messageController.clear();
                                },
                              ),
                            ),
                            IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  context.read<ConversationBloc>().add(
                                      SendMessage(
                                          message: messageController.text,
                                          uid: auth.currentUser?.uid ?? ''));
                                  messageController.clear();
                                }),
                          ],
                        ),
                      ))
                ],
              ),
            );
          },
        );
      }),
    );
  }

  PreferredSize appBar(ConversationState state) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65), // Set this height
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  context.read<ConversationBloc>().add(const StopListen());
                  Navigator.of(context).pop();
                }),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.otherPerson?.fullName ?? '',
                      style: const TextStyle(fontSize: 18)),
                  Text(state.chat?.product?.title ?? '',
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  chatList(List<Message> messages) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        bool isMe = messages[index].sender == auth.currentUser?.uid;
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isMe ? Colors.amber : Colors.blue[200],
            ),
            margin: isMe
                ? const EdgeInsets.only(left: 50, right: 10, bottom: 8)
                : const EdgeInsets.only(left: 10, right: 50, bottom: 8),
            padding: EdgeInsets.all(8),
            child: Text(messages[index].message),
          ),
        );
      },
    );
  }
}
