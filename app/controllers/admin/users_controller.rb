class Admin::UsersController < Admin::ApplicationController

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

    @message = 'User successfully created.'
    redirect_to admin_user_path(@user)

  rescue Exception => e
    logger.error e.message + "\n\n" + e.backtrace.join("\n")

    @user = User.new(:name => params[:name], :password => params[:password])

    @error = e.message
    render :action => "new"
  end

  # PUT admin/users/1
  def update
    @user = User.find(params[:id])

    @user.update_attributes(params.permit(:name, :password, :email))

    @user.save!

    @message = 'User successfully updated.'

    redirect_to admin_user(@user)

  rescue Exception => e
    logger.error e.message + "\n\n" + e.backtrace.join("\n")

    @user = User.find(params[:id])
    @user.name = params[:name]

    @error = e.message

    render :action => "edit"
  end

  # DELETE admin/users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end

end
