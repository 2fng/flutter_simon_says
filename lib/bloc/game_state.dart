part of 'game_bloc.dart';

enum GameStatus { initial, playing, gameOver }

class GameState extends Equatable {
  final GameStatus? status;
  final List<ColoredButton>? simonsPlays;
  final List<ColoredButton>? playerPlays;
  final ColoredButton? pressedButton;

  const GameState(
      {this.simonsPlays,
      this.playerPlays,
      this.pressedButton,
      this.status = GameStatus.initial});

  const GameState.initialize() : this(status: GameStatus.initial);

  @override
  List<Object?> get props => [status, simonsPlays, playerPlays, pressedButton];
}
