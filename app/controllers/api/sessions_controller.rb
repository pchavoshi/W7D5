class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      render 'api/users/show.json.jbuilder'
    else
      render json: {errors: ["Invalid Login Info"], status: 422}
    end
  end

  def destroy
    render {} if !current_user
    if current_user
      logout
    else
      render json: {errors: ['no current user'], status: 404}
    end

  end
end
