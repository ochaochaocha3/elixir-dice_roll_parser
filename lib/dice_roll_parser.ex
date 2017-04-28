defmodule DiceRollParser do
  @moduledoc """
  Documentation for DiceRollParser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DiceRollParser.hello
      :world

  """
  def hello do
    :world
  end

  def tokenize(str) do
    str |> to_charlist |> :dice_roll_lexer.string
  end

  def to_ast(tokens) do
    :dice_roll_parser.parse(tokens)
  end

  def parse(str) do
    tokenize_result = tokenize(str)
    case tokenize_result do
      {:ok, tokens, _} -> to_ast(tokens)
      _ -> tokenize_result
    end
  end

  def evaluate(x) when is_integer(x) do
    x
  end

  def evaluate({:add, a, b}) do
    evaluate(a) + evaluate(b)
  end

  def evaluate({:sub, a, b}) do
    evaluate(a) - evaluate(b)
  end

  def evaluate({:mul, a, b}) do
    evaluate(a) * evaluate(b)
  end

  def evaluate({:div_node, a, b}) do
    div(evaluate(a), evaluate(b))
  end

  def evaluate({:dice_roll, num_node, faces_node}) do
    num = evaluate(num_node)
    faces = evaluate(faces_node)

    :lists.seq(1, num) |>
    Enum.map(fn(_) -> :rand.uniform(faces) end) |>
    Enum.reduce(fn(x, sum) -> sum + x end)
  end
end
