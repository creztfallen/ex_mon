defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game

  @avg_move_power 18..25
  @rnd_move_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:hp)
    |> calculate_life(damage)
    |> update_opponent_life(opponent)
  end

  defp calculate_power(:avg_move), do: Enum.random(@avg_move_power)
  defp calculate_power(:rnd_move), do: Enum.random(@rnd_move_power)

  defp calculate_life(life, damage) when life - damage < 0, do: 0
  defp calculate_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:hp, life)
    |> update_game(opponent)
  end

  defp update_game(player, opponent) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()
  end
end
