class HomeController < ApplicationController
  def index
  end

  def sitter
    @users = User.all
  end
end
