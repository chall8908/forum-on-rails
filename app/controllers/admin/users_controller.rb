class Admin::UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET admin/users/new
  def new
    @user = User.new
  end

  # GET admin/users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST admin/users
  def create
    @user = User.create!(:name => params[:name], :password => params[:password])

    redirect_to admin_user_path(@user), :notice => 'User successfully created.'

  rescue Exception => e
    user_params = params[:user]
    @user = User.new(:name => params[:name], :password => params[:password])

    render :action => "new", :notice => e.message
  end

  # PUT admin/users/1
  def update
    @user = User.find(params[:id])

    @user.name = params[:user][:name]
    @user.password = params[:password]

    @user.save!

    redirect_to @user, :notice => 'User successfully updated.'

  rescue Exception => e
    @user = User.find(params[:id])

    @user.name = params[:user][:name]

    render :action => "edit", :notice => e.message
  end

  # DELETE admin/users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end

end
