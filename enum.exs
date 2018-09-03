defmodule MyEnum do
  def all?([head|tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end
  def all?(_, _) do
    true
  end

  def each([head|tail], func) do
    func.(head)
    each(tail, func)
  end
  def each(_, _func) do
    :ok
  end

  def filter([], _func) do
    []
  end
  def filter([head|tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, count) do
    _split(list, count, { [], []})
  end

  defp _split([], _count, result) do
    result
  end
  defp _split([head|tail], count, { first, second }) do
    if length(first) < count do
      _split( tail, count, { first ++ [head], second })
    else
      _split( tail, count, { first, second ++ [head] })
    end
  end

  def take(_list, 0) do
    []
  end
  def take([head|tail], count) do
    [head | take(tail, count - 1)]
  end

  #def flatten([]) do
    #[]
  #end
  #def flatten([head | tail]) when is_list head do
    #[flatten(head) | tail]
  #end
  #def flatten([head | tail]) do
    #[head | flatten(tail)]
  #end

  def flatten(list) do
    _flatten(list, [])
  end
  defp _flatten([], result) do
    result
  end
  defp _flatten([head| tail], result) do
    if is_list head do
      _flatten(tail, _flatten(head, result))
    else
      _flatten(tail, result ++ [head])
    end
  end

end
