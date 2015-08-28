def best_change(number,change)
  return [] if change == [] || number == 0
  best_solution = nil

  # return solution with the biggest coins
  change.each do |coin|
    next if coin > number
    current_solution = best_change(number-coin, change) << coin
    best_solution ||= current_solution
    if current_solution.length < best_solution.length
      best_solution = current_solution
    end
  end
  best_solution
end
