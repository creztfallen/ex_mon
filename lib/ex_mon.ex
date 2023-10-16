defmodule ExMon do
  alias ExMon.{Game, Player, Game.Status}

  @computer_name "Rasputin"

  def create_player(name, avg_move, rnd_move, heal) do
    Player.build(name, rnd_move, avg_move, heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:laser_beam, :missile_strike, :mechanical_repair)
    |> Game.start(player)

    Status.print_round_message()
  end

end
