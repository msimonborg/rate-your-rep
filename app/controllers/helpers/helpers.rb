# frozen_string_literal: true

# Helper methods for controllers and views
module Helpers
  def logged_in?
    !current_user.blank?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def partial(page, options = {})
    erb(page, options.merge!(layout: false))
  end

  def pluralize(count, singular, plural, inner_string: nil)
    inner_string += ' ' if inner_string
    "#{count} #{inner_string}#{count == 1 ? singular : plural}"
  end

  def display_stars(count)
    stars = []
    count.times do
      stars << "<i class='fa fa-star' aria-hidden='true'></i>"
    end

    (5 - count).times do
      stars << "<i class='fa fa-star-o' aria-hidden='true'></i>"
    end

    stars.join(' ')
  end
end
