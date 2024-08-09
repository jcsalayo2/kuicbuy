import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/services/account_services.dart';
import 'package:kuicbuy/services/product_services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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
      return null;
    }
    var saved = await AccountServices().getSaved(userId: event.uid);

    emit(state.copyWith(saved: saved));

    add(GetProductSaved(saved: saved));
  }

  FutureOr<void> _getProductSaved(
      GetProductSaved event, Emitter<MainState> emit) async {
    var test = await ProductServices().getProductsByIds(saved: event.saved);

    emit(state.copyWith(savedProducts: test));
  }
}
