class ProductsController < ApplicationController

  def index
    @products = Product.all
    respond_to do |format|
      format.html
      
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html
      
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

 
  def update
    @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to @product, notice: 'Se actualizó el producto correctamente'
      else
        render :edit
      end
  end


  def new_movement
    @product = Product.find(params[:id])
    @movement = Movement.new(product_id: @product.id)
  end

  def create_movement
    @product = Product.find(params[:id])
    @movement = Movement.new(movement_params)
    @movement.product_id = @product.id
    if @movement.save
      redirect_to @product, notice: 'Se creó el movimiento correctamente'
    else
      flash[:notice] = 'Ha ocurrido un error al crear el movimiento.'
      render :new_movement, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :reference)
  end

  def movement_params 
    params.require(:movement).permit(:movement_type, :quantity, :comment)
  end
    
end