module Helpers
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    logged_in? && User.find(session[:user_id])
  end

  def partial(page, options={})
    erb page, options.merge!(layout: false)
  end

  def pluralize(count, singular, plural, inner_string: nil)
    inner_string = inner_string + ' ' if inner_string
    "#{count} #{inner_string}#{count == 1 ? singular : plural}"
  end

  def display_stars(object)
    stars = []
    object.calls.stars.times do
      stars << "<i class='fa fa-star' aria-hidden='true'></i>"
    end

    (5 - object.calls.stars).times do
      stars << "<i class='fa fa-star-o' aria-hidden='true'></i>"
    end

    stars.join(' ')
  end
end
