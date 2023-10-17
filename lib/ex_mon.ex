defmodule ExMon do
  alias ExMon.{Game, Game.Actions, Game.Status, Player}

  @computer_name "Rasputin"

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
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :heal -> "Heal Player"
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end
end
