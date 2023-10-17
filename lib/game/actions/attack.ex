defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  @avg_move_power 18..25
  @rnd_move_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:hp)
    |> calculate_life(damage)
    |> update_opponent_life(opponent, damage)
  end

  defp calculate_power(:avg_move), do: Enum.random(@avg_move_power)
  defp calculate_power(:rnd_move), do: Enum.random(@rnd_move_power)

  defp calculate_life(life, damage) when life - damage < 0, do: 0
  defp calculate_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:hp, life)
    |> update_game(opponent, damage)
  end

  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
