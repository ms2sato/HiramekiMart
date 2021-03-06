class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_editable, only: [:edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.price_range(params[:price]).category(params[:category]).page(params[:page])
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @favorite = @item.find_fav(current_user) if user_signed_in?
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item.image.cache! unless @item.image.blank?
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.build(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'アイテムが出品されました' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'アイテム情報が更新されました' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'アイテムが削除されました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(
        :user_id, :name, :image, :image_cache, :description, :target_price, :limited_at, :category, :support_course
      )
    end

    # Check if the owner of the item.
    def check_editable
      raise PermissionDeniedError, "アクセス権がありません" unless @item.editable_by?(current_user)
    end
end
