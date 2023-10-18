defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "return a player" do
      expected_response = %Player{
        name: "Draugnav",
        hp: 100,
        moves: %{heal: :potion, avg_move: :gun_shot, rnd_move: :granade}
      }

      assert expected_response == ExMon.create_player("Draugnav", :gun_shot, :granade, :potion)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do

    player = Player.build("Draugnav", :gun_shot, :granade, :potion)

    messages =
      capture_io(fn ->
         assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game has started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end
end
