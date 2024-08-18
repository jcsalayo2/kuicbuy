import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/account_model.dart';
import 'package:kuicbuy/models/chat_model.dart';
import 'package:kuicbuy/models/message_model.dart';
import 'package:kuicbuy/services/account_services.dart';
import 'package:kuicbuy/services/chat_services.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationState.initial()) {
    on<ConversationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ListenToConversation>(_listenToConversation);
    on<SaveMessage>(_saveMessages);
    on<GetChatDetails>(_getChatDetails);
    on<SendMessage>(_sendMessage);
    on<UpdateChat>(_updateChat);
    on<StopListen>(_stopListen);
  }

  FutureOr<void> _listenToConversation(
      ListenToConversation event, Emitter<ConversationState> emit) {
    if (state.conversationState != null) {
      state.conversationState!.cancel();
    }

    var conversationListener =
        ChatServices().listenToConversation(chatId: event.chatId);

    var conversationState = conversationListener.listen((data) {
      var messages = data.docs.map((doc) {
        Object? response = doc.data();
        return Message.fromJson(response as Map<String, dynamic>);
      }).toList();

      add(SaveMessage(messages: messages));
    });

    emit(state.copyWith(conversationState: conversationState));
  }

  FutureOr<void> _saveMessages(
      SaveMessage event, Emitter<ConversationState> emit) {
    emit(state.copyWith(messages: event.messages));
  }

  FutureOr<void> _getChatDetails(
      GetChatDetails event, Emitter<ConversationState> emit) async {
    String otherPersonId = event.chat.members.firstWhere((x) => x != event.uid);

    Account otherPerson =
        await AccountServices().getUser(userId: otherPersonId);

    emit(state.copyWith(
      otherPerson: otherPerson,
      chat: event.chat,
      timestamp: DateTime.now(),
    ));
  }

  FutureOr<void> _sendMessage(
      SendMessage event, Emitter<ConversationState> emit) {
    var message = Message(
        id: null,
        message: event.message,
        messageType: MessageType.text.name,
        sender: event.uid,
        timestamp: DateTime.now());

    ChatServices()
        .sendMessage(uid: event.uid, message: message, chatId: state.chat!.id);

    add(UpdateChat(message: message, uid: event.uid));
  }

  FutureOr<void> _updateChat(
      UpdateChat event, Emitter<ConversationState> emit) {
    ChatServices().updateChat(chatId: state.chat!.id, message: event.message);
  }

  FutureOr<void> _stopListen(
      StopListen event, Emitter<ConversationState> emit) {
    if (state.conversationState != null) {
      state.conversationState!.cancel();
    }
  }
}
