import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/models/account_model.dart';
import 'package:kuicbuy/models/chat_model.dart';
import 'package:kuicbuy/models/grouped_saved_products.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/home/bloc/product_list_bloc.dart';
import 'package:kuicbuy/services/account_services.dart';
import 'package:kuicbuy/services/chat_services.dart';
import 'package:kuicbuy/services/product_services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import "package:collection/collection.dart";
import 'dart:convert';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<MainEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChangeNavBarSettings>(_changeNavBarSettings);
    on<GetSaved>(_getSaved);
    on<GetProductSaved>(_getProductSaved);
    on<RemoveSaved>(_removeSaved);
    on<StartChat>(_startChat);
    // on<GetChats>(_getChats);
    on<ListenToChats>(_listenToChats);
    on<GetProductsInChat>(_getProductsInChat);
    on<SaveChatListener>(_saveChatListener);
  }

  FutureOr<void> _changeNavBarSettings(
      ChangeNavBarSettings event, Emitter<MainState> emit) {
    if (event.index != null) {
      state.controller.jumpToTab(event.index!);
    }

    emit(state.copyWith(
      isVisible: event.isVisible,
    ));
  }

  FutureOr<void> _getSaved(GetSaved event, Emitter<MainState> emit) async {
    if (event.uid == "") {
      return;
    }
    var saved = await AccountServices().getSaved(userId: event.uid);

    if (saved.isEmpty) {
      return;
    }

    emit(state.copyWith(saved: saved));

    add(GetProductSaved(saved: saved));
  }

  FutureOr<void> _getProductSaved(
      GetProductSaved event, Emitter<MainState> emit) async {
    var savedProducts =
        await ProductServices().getProductsByIds(productIds: event.saved);

    var groupedSavedProductsMap =
        savedProducts.groupListsBy((element) => element.sellerId);

    List<Future<Account>> sellerDetails = [];

    for (var sellerId in groupedSavedProductsMap.keys) {
      sellerDetails.add(AccountServices().getUser(userId: sellerId));
    }

    var accounts = await sellerDetails.wait;

    emit(state.copyWith(
        groupSavedProducts:
            groupedSavedProductsFromMap(groupedSavedProductsMap, accounts)));
  }

  FutureOr<void> _removeSaved(
      RemoveSaved event, Emitter<MainState> emit) async {
    if (event.uid == '') {
      return;
    }
    await ProductServices().removeToSaved(id: event.productId, uid: event.uid);

    add(GetSaved(uid: event.uid));
  }

  FutureOr<void> _startChat(StartChat event, Emitter<MainState> emit) async {
    if (event.uid == '') {
      return;
    }
    var existingChatId = await ChatServices()
        .isChatExist(uid: event.uid, product: event.product);
    if (existingChatId != null) {
      emit(state.copyWith(
        existingChatId: existingChatId,
        timestamp: DateTime.now(),
      )); // Triggers chat

      return;
    }

    var newChat = await ChatServices().startChat(
      uid: event.uid,
      product: event.product,
    );

    emit(state.copyWith(
      newChat: newChat,
      timestamp: DateTime.now(),
    )); // Triggers chat
  }

  FutureOr<void> _listenToChats(
      ListenToChats event, Emitter<MainState> emit) async {
    if (event.uid == '') {
      return;
    }
    if (state.chatIdsListenerState != null) {
      state.chatIdsListenerState!.cancel();
    }

    var chatIdsListener = AccountServices().listenToChatIds(userId: event.uid);

    var chatIdsListenerState = chatIdsListener.listen((data) {
      if (state.chatsListenerState != null) {
        state.chatsListenerState!.cancel();
      }

      final chatIds = data.docs.map((doc) => doc.id).toList();

      if (chatIds.isEmpty) {
        return;
      }

      var chatsListener =
          ChatServices().listenToChats(uid: event.uid, chatIds: chatIds);

      var chatsListenerState = chatsListener.listen((data) {
        var chats = data.docs.map((doc) {
          Object? response = doc.data();
          return Chat.fromJson(response as Map<String, dynamic>);
        }).toList();

        add(GetProductsInChat(chats: chats));
      });

      add(SaveChatListener(chatsListenerState: chatsListenerState));
    });

    emit(state.copyWith(chatIdsListenerState: chatIdsListenerState));
  }

  FutureOr<void> _getProductsInChat(
      GetProductsInChat event, Emitter<MainState> emit) async {
    emit(state.copyWith(chats: event.chats));

    var newChats = event.chats;

    List<String> productIds = [];

    for (var chat in newChats) {
      productIds.add(chat.productId);
    }

    var products =
        await ProductServices().getProductsByIds(productIds: productIds);

    for (var chat in newChats) {
      chat.product =
          products.firstWhere((product) => product.id == chat.productId);
    }

    emit(state.copyWith(
      chats: newChats,
      timestamp: DateTime.now(),
    ));
  }

  FutureOr<void> _saveChatListener(
      SaveChatListener event, Emitter<MainState> emit) {
    emit(state.copyWith(chatsListenerState: event.chatsListenerState));
  }
}
