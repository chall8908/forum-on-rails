class UsersController < ApplicationController

  before_filter :ensure_admin, :except => [:index, :show, :get_user_rank]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    user_params = params[:user]
    @user = User.create! :name => user_params[:name], :password => user_params[:password]

    redirect_to @user, :notice => 'User successfully created.'
  
  rescue Exception => e
    user_params = params[:user]
    @user = User.new :name => user_params[:name], :password => user_params[:password]
    
    render :action => "new"
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    
    @user.name = params[:user][:name]
    @user.password = params[:user][:password]
    
    @user.save!
    
    redirect_to @user, :notice => 'User successfully updated.'
    
  rescue Exception => e
    @user = User.find(params[:id])
    
    @user.name = params[:user][:name]
    @user.password = params[:user][:password]
    
    render :action => "edit"
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end
  
  def get_user_rank
    user = User.find_user params[:username], params[:password]
    
    render :json => user.andand.rank
    
  rescue BadUsernameOrPasswordException => e
    render :json => e
  end
  
  private
  def ensure_admin
    redirecet_to root_path unless session[:user].andand.has_permission(:admin)
  end
end
