class PicturesController < ApplicationController
  # before_action :authenticate_user, only: [:edit, :update, :destroy ]

  def index
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to pictures_path, notice: '投稿しました！'
    else
      render :new
    end
  end
  #   respond_to do |format|
  #     if @picture.save
  #       format.html { redirect_to feed_url(@feed), notice: "picture was successfully created." }
  #       format.json { render :show, status: :created, location: @feed }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @feed.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: '投稿を更新しました！'
    else
      render :edit
    end
  end
  #   respond_to do |format|
  #     if @feed.update(feed_params)
  #       format.html { redirect_to feed_url(@feed), notice: "picture was successfully updated." }
  #       format.json { render :show, status: :ok, location: @feed }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @feed.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      redirect_to pictures_path, notice: '投稿を削除しました！'
    else
      render :index
    end
  end
  #   respond_to do |format|
  #     format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end
  private

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end
end
