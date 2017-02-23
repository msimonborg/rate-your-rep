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
end
