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
end
