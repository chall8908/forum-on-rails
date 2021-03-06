﻿class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  def register
    @user = User.new

    if(params[:user])
      @user = User.create!(user_params)
      render :show
    end
  end

  def get_user_rank
    user = User.find_user params[:username], params[:password]

    render :json => user.andand.rank

  rescue BadUsernameOrPasswordError => e
    render :json => e
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
