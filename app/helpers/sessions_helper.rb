module SessionsHelper

  def log_in(user)
    session[:user_id]=user.id
  end

  #現在のユーザー
  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end

  #ログインしているかしていないか判別
  def logged_in?
    !current_user.nil?
  end

  #渡されたユーザーが現在のユーザーならtrue
  def current_user?(user)
    user==current_user
  end

end
