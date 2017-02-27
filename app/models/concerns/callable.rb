module Callable
  def average_call_rating
    calls.average('rating').round(1)
  end

  def recent_calls_count
    calls.this_week.count
  end

  def calls_count
    calls.count
  end

  def no_calls?
    calls.blank?
  end

  def time_sorted_calls
    calls.time_sorted
  end

  def last_call
    calls.last_call
  end
end
