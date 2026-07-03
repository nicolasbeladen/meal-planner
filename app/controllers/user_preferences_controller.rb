class UserPreferencesController < ApplicationController
  def edit
    @user_preference = current_user.user_preference || current_user.build_user_preference
  end

  def update
    @user_preference = current_user.user_preference || current_user.build_user_preference
    if @user_preference.update(user_preference_params)
      redirect_to menus_path, notice: "Preferences updated!"
    else
      render :edit
    end
  end

  private

  def user_preference_params
    params.require(:user_preference).permit(:cooking_skill, :household_size, :max_cooking_time)
  end
end
