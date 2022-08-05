class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :edit, :update]
  before_action :authenticate_user, only: [:show, :edit, :update ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザー情報を更新しました！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :image, :image_cache )
  end

  def authenticate_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = "アクセスする権限がありません"
      redirect_to new_session_path
    end
  end
end
