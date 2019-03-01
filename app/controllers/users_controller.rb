class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save                       #com informaçao invalida a tentativa de update return false
      log_in @user
      # Handle a successful save.
      
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #caso de sucesso
      flash[:success]="Profile UPDATED"
      redirect_to @user
    else
      #caso de falha
      render 'edit'
    end
  end


  #para que serve? R->
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
