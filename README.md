# Project ExMon

## Game Explanation

- Turn-based game where a player competes against the computer.
- Both human and computer start with 100 points of health.
- In each round, each player can choose one of three moves:
  - Moderate Attack, dealing between (18-25) damage.
  - Varied Attack, dealing between (10-35) damage.
  - Healing Power, restoring between (18-25) health.

## Game Rules

- After each move, the game should display what happened and the situation of each player.
- If either the player or the computer reaches 0 health, the game ends.
- If someone loses, the final result should not display negative health.

## Customization

- The human player can choose the name of their character as well as the names of their three moves.

## Recommended Study Topics

- [Maps](https://hexdocs.pm/elixir/Map.html)
- [Structs](https://elixir-lang.org/getting-started/structs.html)
- [Agent](https://hexdocs.pm/elixir/Agent.html)

## Player

- **Moves:**

  - Moderate Attack
  - Varied Attack
  - Healing

- 100 points of health
- Name
