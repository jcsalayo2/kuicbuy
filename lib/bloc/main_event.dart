part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class ChangeNavBarSettings extends MainEvent {
  final bool? isVisible;
  final int? index;

  const ChangeNavBarSettings({
    this.isVisible,
    this.index,
  });
}

class GetSaved extends MainEvent {
  final String uid;

  const GetSaved({required this.uid});
}

class GetProductSaved extends MainEvent {
  final List<String> saved;

  const GetProductSaved({required this.saved});
}

class RemoveSaved extends MainEvent {
  final String productId;
  final String uid;

  const RemoveSaved({required this.productId, required this.uid});
}

class StartChat extends MainEvent {
  final Product product;
  final String uid;

  const StartChat({required this.product, required this.uid});
}

// class GetChats extends MainEvent {
//   final String uid;

//   const GetChats({required this.uid});
// }

class ListenToChats extends MainEvent {
  final String uid;

  const ListenToChats({required this.uid});
}

class GetProductsInChat extends MainEvent {
  final List<Chat> chats;

  const GetProductsInChat({required this.chats});
}

class SaveChatListener extends MainEvent {
  final StreamSubscription<QuerySnapshot<Object?>> chatsListenerState;

  const SaveChatListener({required this.chatsListenerState});
}
