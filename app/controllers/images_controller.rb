class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /images or /images.json
  def index
    @images = Image.all.where(user_id: current_user.id).order("created_at DESC").paginate(page: params[:pag_images], per_page: 5)
  end

  # GET /images/1 or /images/1.json
  def show
    @image = Image.find(params[:id])
    if current_user.id != @image.user_id
      flash[:alert] = "You can only delete/edit your own article."
      redirect_to root_path
    end
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:name, :picture).merge(user: current_user)
    end

    def require_same_user
      if current_user.id != @image.user_id
        flash[:alert] = "You can only delete/edit your own article."
        redirect_to root_path
      end
    end
end
