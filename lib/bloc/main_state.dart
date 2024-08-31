part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isVisible;
  final PersistentTabController controller;
  final List<String> saved;
  final List<GroupedSavedProducts> groupSavedProducts;
  final List<Chat> chats;
  final DateTime timestamp; // used for forced emit
  final StreamSubscription<QuerySnapshot<Object?>>? chatsListenerState;
  final StreamSubscription<QuerySnapshot<Object?>>? chatIdsListenerState;
  final String? existingChatId;
  final Chat? newChat;

  const MainState({
    required this.isVisible,
    required this.controller,
    required this.saved,
    required this.groupSavedProducts,
    required this.chats,
    required this.timestamp,
    required this.chatsListenerState,
    required this.chatIdsListenerState,
    required this.existingChatId,
    required this.newChat,
  });

  MainState.initial()
      : isVisible = true,
        controller = PersistentTabController(initialIndex: 0),
        saved = [],
        groupSavedProducts = [],
        chats = [],
        timestamp = DateTime.now(),
        chatsListenerState = null,
        chatIdsListenerState = null,
        existingChatId = null,
        newChat = null;

  @override
  List<Object> get props => [
        isVisible,
        controller,
        saved,
        groupSavedProducts,
        chats,
        timestamp,
      ];

  MainState copyWith({
    bool? isVisible,
    PersistentTabController? controller,
    List<String>? saved,
    List<GroupedSavedProducts>? groupSavedProducts,
    List<Chat>? chats,
    DateTime? timestamp,
    StreamSubscription<QuerySnapshot<Object?>>? chatsListenerState,
    StreamSubscription<QuerySnapshot<Object?>>? chatIdsListenerState,
    String? existingChatId,
    Chat? newChat,
  }) {
    return MainState(
      isVisible: isVisible ?? this.isVisible,
      controller: controller ?? this.controller,
      saved: saved ?? this.saved,
      groupSavedProducts: groupSavedProducts ?? this.groupSavedProducts,
      chats: chats ?? this.chats,
      timestamp: timestamp ?? this.timestamp,
      chatsListenerState: chatsListenerState ?? this.chatsListenerState,
      chatIdsListenerState: chatIdsListenerState ?? this.chatIdsListenerState,
      existingChatId: existingChatId,
      newChat: newChat,
    );
  }
}
