defmodule MyString do
  #def is_printable([head|tail]) when head in 32..255 do
    #is_printable(tail)
  #end
  #def is_printable([head|_tail]) when head not in 32..255 do
    #false
  #end
  #def is_printable(_) do
    #true
  #end
  def is_printable(str) do
    Enum.all?(str, fn x -> x in ?\s..?~ end)
  end

  def anagram?(word1, word2) do
    Enum.sort(word1) == Enum.sort(word2)
  end

  def calculate(str) do
    {n1, rest} = parse_number(str)
    rest = _skip_spaces(rest)
    {op, rest} = parse_op(rest)
    rest = _skip_spaces(rest)
    {n2, []} = parse_number(rest)
    op.(n1, n2)
  end

  defp parse_number(str) do
    _parse_number({0, str})
  end

  defp _parse_number({value, [digit|tail]}) when digit in ?0..?9 do
    _parse_number({value*10 + digit - ?0, tail})
  end
  defp _parse_number(result), do: result

  defp _skip_spaces([ ?\s | tail ]) do
    _skip_spaces( tail )
  end
  defp _skip_spaces( tail ), do: tail

  defp parse_op( [?+ | tail] ), do: {&(&1 + &2), tail}
  defp parse_op( [?- | tail] ), do: {&(&1 - &2), tail}
  defp parse_op( [?* | tail] ), do: {&(&1 * &2), tail}
  defp parse_op( [?/ | tail] ), do: {&(div(&1, &2)), tail}
  
  def center(list) do
    block_length = list
    |> Enum.map( fn x -> String.length(x) end )
    |> Enum.max
    
    Enum.each( list, fn(x) -> IO.puts _print_line(block_length, x) end )
  end
  
  defp _print_line(block_length, line) do
    padding = div(block_length - String.length(line), 2) + String.length(line)
    
    String.pad_leading( line, padding )
  end
  
  
  def capitalize_sentences( str) do
    str
    |> String.split(". ")
    |> Enum.map( &(String.capitalize(&1)) )
    |> Enum.join( ". " )
  end
  
end