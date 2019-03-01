class SessionsController < ApplicationController
   
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user  #vem do session helper

      #remember user #vem do session helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) #é true dependendo do contexto
      

      redirect_to user #?
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right! missing .now fixed
      render 'new'
    end
  end
 
  def destroy
    log_out if logged_in? #so pode dar logout se estiver logedin	
    redirect_to root_url
  end
end