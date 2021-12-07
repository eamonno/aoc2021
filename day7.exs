input =
  File.read!("day/7/input")
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

for fuel_calculation <- [& &1, &div((&1 + 1) * &1, 2)] do
  Enum.map(Enum.min(input)..Enum.max(input), fn pos ->
    Enum.map(input, &fuel_calculation.(Kernel.abs(&1 - pos)))
    |> Enum.sum()
  end)
  |> Enum.min()
  |> IO.inspect()
end
