import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../src/domain/entities/colored_button.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState.initialize()) {
    on<GameEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GameColoredButtonPressed>((event, emit) {
      List<ColoredButton> simonPlays = state.simonsPlays ?? [];
      List<ColoredButton> playerPlays = state.playerPlays ?? [];
      if (playerPlays.isNotEmpty &&
          simonPlays.isNotEmpty &&
          simonPlays[playerPlays.length - 1] != state.pressedButton) {
        print('Game over');
      }
    });
  }
}
