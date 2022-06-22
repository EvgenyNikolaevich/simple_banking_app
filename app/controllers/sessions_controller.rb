class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(login: params[:login])

    if @user && password_correct?
      sessions[:user_id] = @user.id

      redirect_to '/welcome'
    else
      redirect_to '/login'
    end
  end

  def password_correct?
    ActiveSupport::SecurityUtils.secure_compare(params[:password], @user.password)
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
