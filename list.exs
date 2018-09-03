defmodule MyList do
  def reduce([], value, _) do
    value
  end
  def reduce([head | tail], value, func) do
    reduce( tail, func.(head, value), func)
  end

  def map([], _func) do
    []
  end
  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end

  def mapsum(list, func) do
    map(list, func)
    |> reduce(0, &(&1 + &2))
  end

  def max(list) do
    reduce(list, 0, &max/2)
  end

  def span(a, a) do
    [a]
  end
  def span(a, b) when a < b do
    [a | span(a + 1, b)]
  end

  def taxcalc(rates, orders) do
    # Enum.map( orders, fn x -> _taxcalc(x, rates) end) 
    Enum.map( orders, _taxcalc(&1, rates) )
  end

  defp _taxcalc(order = [id: _, ship_to: state, net_amount: net_amount], rates) do
    tax_rate = Keyword.get(rates, state, 0)
    total_amount = net_amount * (1 + tax_rate)
    Keyword.put(order, :total_amount, total_amount)
  end
end

orders = [
        [ id: 123, ship_to: :NC, net_amount: 100.00 ],
        [ id: 124, ship_to: :OK, net_amount:  35.50 ],
        [ id: 125, ship_to: :TX, net_amount:  24.00 ],
        [ id: 126, ship_to: :TX, net_amount:  44.80 ],
        [ id: 127, ship_to: :NC, net_amount:  25.00 ],
        [ id: 128, ship_to: :MA, net_amount:  10.00 ],
        [ id: 129, ship_to: :CA, net_amount: 102.00 ],
        [ id: 130, ship_to: :NC, net_amount:  50.00 ] ]

tax_rates = [ NC: 0.075, TX: 0.08 ]