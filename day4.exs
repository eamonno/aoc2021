defmodule BingoBoard do
  defstruct [:squares]

  @rows 0..24 |> Enum.chunk_every(5)
  @cols @rows |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  @wins @rows ++ @cols

  def create(nums), do: %__MODULE__{squares: Enum.map(nums, fn num -> {:unmarked, num} end)}

  def mark(%__MODULE__{squares: squares} = board, num) do
    case Enum.find_index(squares, fn s -> {:unmarked, num} == s end) do
      nil -> board
      n -> %{board | squares: List.replace_at(squares, n, {:marked, num})}
    end
  end

  def score(%__MODULE__{squares: squares}, last_ball) do
    case @wins
         |> Enum.map(fn indices -> Enum.map(indices, &Enum.at(squares, &1)) end)
         |> Enum.filter(fn row_or_col -> Enum.all?(row_or_col, &(elem(&1, 0) == :marked)) end) do
      [] ->
        nil

      [_ | _] ->
        {:win,
         last_ball *
           (squares
            |> Enum.reduce(0, fn
              {:marked, _}, sum -> sum
              {:unmarked, n}, sum -> sum + n
            end))}
    end
  end

  def find_place(boards, balls, place) do
    boards_remaining = length(boards) + 1 - place

    Enum.reduce_while(balls, boards, fn ball, boards ->
      boards = boards |> Enum.map(&BingoBoard.mark(&1, ball))

      case {length(boards), Enum.find_value(boards, &BingoBoard.score(&1, ball))} do
        {^boards_remaining, {:win, score}} ->
          {:halt, score}

        _ ->
          {:cont, boards |> Enum.reject(&BingoBoard.score(&1, ball))}
      end
    end)
  end

  def print(%__MODULE__{squares: squares}) do
    squares
    |> Enum.with_index()
    |> Enum.map(fn {sq, index} ->
      case sq do
        {:marked, num} ->
          IO.ANSI.light_green() <> String.pad_leading(Integer.to_string(num), 3) <> " "

        {:unmarked, num} ->
          IO.ANSI.light_white() <> String.pad_leading(Integer.to_string(num), 3) <> " "
      end <> if(index > 0 and rem(index + 1, 5) == 0, do: "\n", else: "") <> IO.ANSI.reset()
    end)
    |> Enum.join()
    |> IO.puts()
  end
end

[ball_data | board_data] = File.read!("day/4/input") |> String.split() |> List.flatten()
balls = ball_data |> String.split(",") |> Enum.map(&String.to_integer/1)

boards =
  board_data
  |> Enum.map(&String.to_integer/1)
  |> Enum.chunk_every(25)
  |> Enum.map(&BingoBoard.create/1)

first_place = BingoBoard.find_place(boards, balls, 1)
last_place = BingoBoard.find_place(boards, balls, length(boards))

IO.puts("First place scores #{first_place}, last place scores #{last_place}.")
