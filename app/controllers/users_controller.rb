class UsersController < ApplicationController

  def index
    @users=User.all
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
