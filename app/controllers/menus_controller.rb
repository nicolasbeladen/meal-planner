class MenusController < ApplicationController
  def index
    @menu = current_user.menus.last
    if @menu
      @recipes = @menu.recipes
    else
      @recipes = []
    end
  end
end
