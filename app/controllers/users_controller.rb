class UsersController < ApplicationController

  before_filter :ensure_admin, :except => [:index, :show, :get_user_rank]
  
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.create!(:name => params[:user][:name], :password => params[:password])

    redirect_to @user, :notice => 'User successfully created.'
  
  rescue Exception => e
    user_params = params[:user]
    @user = User.new(:name => params[:user][:name], :password => params[:password])
    
    render :action => "new", :notice => e.message
  end

  # PUT /users/1
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

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end
  
  def get_user_rank
    user = User.find_user params[:username], params[:password]
    
    render :json => user.andand.rank
    
  rescue BadUsernameOrPasswordError => e
    render :json => e
  end
  
  private
  def ensure_admin
    redirecet_to root_path unless session[:user].andand.has_permission(:admin)
  end
end