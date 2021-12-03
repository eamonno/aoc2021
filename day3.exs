input =
  File.stream!("day/3/input", [], :line)
  |> Stream.map(&String.trim/1)
  |> Stream.map(&String.to_integer(&1, 2))
  |> Enum.to_list()

defmodule Day3 do
  use Bitwise

  @high_bit 11

  def gamma_epsilon(numbers) do
    Enum.reduce(@high_bit..0, {0, 0}, fn bit, {gamma, epsilon} ->
      if Day3.bit_delta(numbers, bit) > 0 do
        {gamma ||| 1 <<< bit, epsilon}
      else
        {gamma, epsilon ||| 1 <<< bit}
      end
    end)
  end

  def oxygen_generator_rating(numbers),
    do: find_rating(numbers, fn delta -> if(delta >= 0, do: 1, else: 0) end)

  def co2_scrubber_rating(numbers),
    do: find_rating(numbers, fn delta -> if(delta >= 0, do: 0, else: 1) end)

  defp bit_delta(numbers, bit) do
    mask = 1 <<< bit

    Enum.reduce(numbers, 0, fn num, delta ->
      if (num &&& mask) > 0 do
        delta + 1
      else
        delta - 1
      end
    end)
  end

  defp find_rating(numbers, keep_func) do
    Enum.reduce_while(@high_bit..0, numbers, fn bit, numbers ->
      keep_value = keep_func.(bit_delta(numbers, bit)) <<< bit
      keep_mask = 1 <<< bit
      keep_list = Enum.filter(numbers, fn number -> (number &&& keep_mask) == keep_value end)

      if length(keep_list) == 1 do
        {:halt, hd(keep_list)}
      else
        {:cont, keep_list}
      end
    end)
  end
end

{gamma, epsilon} = Day3.gamma_epsilon(input)
IO.puts("Gamma: #{gamma}, Epsilon: #{epsilon}, Power Consumption: #{gamma * epsilon}")

ogr = Day3.oxygen_generator_rating(input)
csr = Day3.co2_scrubber_rating(input)
IO.puts("Oxygen Generator Rating: #{ogr}, CO₂ Scrubber Rating: #{csr}, Life Support Rating: #{ogr * csr}")
