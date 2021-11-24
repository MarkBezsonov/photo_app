class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user
      @images = Image.where(user_id: current_user.id).all.order("created_at DESC").paginate(page: params[:pag_images], per_page: 5)
    end
  end
end
