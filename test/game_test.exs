defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Draugnav", :gun_shot, :granade, :potion)
      computer = Player.build("Rasputin", :laser_beam, :missile_strike, :mechanical_repair)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Draugnav", :gun_shot, :granade, :potion)
      computer = Player.build("Rasputin", :laser_beam, :missile_strike, :mechanical_repair)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        turn: :player,
        computer: %ExMon.Player{
          name: "Rasputin",
          hp: 100,
          moves: %{
            heal: :mechanical_repair,
            avg_move: :laser_beam,
            rnd_move: :missile_strike
          }
        },
        player: %ExMon.Player{
          name: "Draugnav",
          hp: 100,
          moves: %{heal: :potion, avg_move: :gun_shot, rnd_move: :granade}
        }
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Draugnav", :gun_shot, :granade, :potion)
      computer = Player.build("Rasputin", :laser_beam, :missile_strike, :mechanical_repair)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        turn: :player,
        computer: %ExMon.Player{
          name: "Rasputin",
          hp: 100,
          moves: %{
            heal: :mechanical_repair,
            avg_move: :laser_beam,
            rnd_move: :missile_strike
          }
        },
        player: %ExMon.Player{
          name: "Draugnav",
          hp: 100,
          moves: %{heal: :potion, avg_move: :gun_shot, rnd_move: :granade}
        }
      }

      assert expected_response == Game.info()

      new_state = %{
          status: :started,
          turn: :player,
          computer: %ExMon.Player{
            name: "Rasputin",
            hp: 85,
            moves: %{
              heal: :mechanical_repair,
              avg_move: :laser_beam,
              rnd_move: :missile_strike
            }
          },
          player: %ExMon.Player{
            name: "Draugnav",
            hp: 50,
            moves: %{heal: :potion, avg_move: :gun_shot, rnd_move: :granade}
          }
        }

        Game.update(new_state)

        expected_response = %{new_state | turn: :computer, status: :continue}

        assert expected_response == Game.info()
    end
  end
end
