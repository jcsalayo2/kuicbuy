part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class ListenToConversation extends ConversationEvent {
  final String chatId;

  const ListenToConversation({required this.chatId});
}

class SaveMessage extends ConversationEvent {
  final List<Message> messages;

  const SaveMessage({required this.messages});
}

class GetChatDetails extends ConversationEvent {
  final Chat chat;
  final String uid;

  const GetChatDetails({required this.chat, required this.uid});
}

class SendMessage extends ConversationEvent {
  final String message;
  final String uid;

  const SendMessage({required this.message, required this.uid});
}

class UpdateChat extends ConversationEvent {
  final Message message;
  final String uid;

  const UpdateChat({required this.message, required this.uid});
}

class StopListen extends ConversationEvent {
  const StopListen();
}
