defmodule GuessingGame do

  @max 100
  @rounds 5

  def start() do
    goal = Enum.random(1..@max)
    round(goal, @rounds)
  end

  def round(goal, 1) do
    get_guess(1)
    |> result(goal)
    |> game_over(goal)
  end

  def round(goal, rounds_remaining) do
    get_guess(rounds_remaining)
    |> result(goal)
    |> notify_user()
    |> case do
      :equal -> IO.puts "With #{rounds_remaining - 1} guesses left!"
      _ -> round(goal, rounds_remaining - 1)
    end
  end

  def notify_user(round_result) do
    case round_result do
      :low -> "Not quite enough"
      :high -> "Too much, yo"
      :equal -> "Congrats. Nailed it!"
    end
    |> IO.puts
    round_result
  end

  def game_over(round_result, goal) do
    case round_result do
      :equal -> "Congrats. Nailed it!"
      _ -> "You lost. :( The number was #{goal}."
    end
    |> IO.puts
  end

  def result(guess, goal) do
    case guess - goal do
      x when x < 0 -> :low
      x when x > 0 -> :high
      0 -> :equal
    end
  end

  def get_guess(rounds_remaining) do
    IO.gets("Pick a number between 1 - #{@max}. You have #{rounds_remaining} guesses.\n")
    |> String.trim()
    |> String.to_integer()
  end
end

GuessingGame.start
