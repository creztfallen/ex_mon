defmodule ExMon do
  alias ExMon.{Game, Game.Actions, Game.Status, Player}

  @computer_name "Rasputin"
  @computer_moves [:avg_move, :rnd_move, :heal]
  @computer_moves_low_health [:avg_move, :rnd_move, :heal, :heal]

  def create_player(name, avg_move, rnd_move, heal) do
    Player.build(name, avg_move, rnd_move, heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:laser_beam, :missile_strike, :mechanical_repair)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end
  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end
end
