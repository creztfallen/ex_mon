defmodule ExMon.Player do
  @required_keys [:name, :hp,  :moves]
  @max_hp 100

  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name, avg_move, rnd_move, heal) do
    %ExMon.Player{
      name: name,
      hp: @max_hp,
      moves: %{
        avg_move: avg_move,
        rnd_move: rnd_move,
        heal: heal,
      }
    }
  end
end
