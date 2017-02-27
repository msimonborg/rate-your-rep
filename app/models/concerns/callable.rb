module Callable
  def average_call_rating
    calls.average('rating').round(1)
  end

  def recent_calls
    calls.this_week
  end

  def recent_calls_count
    recent_calls.count
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

  def last_call_time
    last_call.time
  end

  def calls_stars
    calls.stars
  end
end
