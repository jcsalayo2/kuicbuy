part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final DateTime timestamp; //Use for force emit
  final StreamSubscription<QuerySnapshot<Object?>>? conversationState;
  final List<Message> messages;
  final Chat? chat;
  final Account? otherPerson;

  const ConversationState({
    required this.timestamp,
    this.conversationState,
    required this.messages,
    this.chat,
    this.otherPerson,
  });

  ConversationState.initial()
      : timestamp = DateTime.now(),
        conversationState = null,
        messages = [],
        chat = null,
        otherPerson = null;

  @override
  List<Object> get props => [
        timestamp,
        messages,
      ];

  ConversationState copyWith({
    DateTime? timestamp,
    StreamSubscription<QuerySnapshot<Object?>>? conversationState,
    List<Message>? messages,
    Chat? chat,
    Account? otherPerson,
  }) {
    return ConversationState(
      timestamp: timestamp ?? this.timestamp,
      conversationState: conversationState ?? this.conversationState,
      messages: messages ?? this.messages,
      chat: chat ?? this.chat,
      otherPerson: otherPerson ?? this.otherPerson,
    );
  }
}
