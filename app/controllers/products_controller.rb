class ProductsController < ApplicationController
  before_action :set_department
  before_action :set_product, only: [:show, :update, :destroy, :assign_promotion]

  # GET /products
  def index
    @products = @department.products.all
    json_response(@products)
  end

  # POST /products
  def create
    @product = @department.products.create!(product_params)
    json_response(@product, :created)
  end

  # GET /products/:id
  def show
    json_response(@product)
  end

  # PUT /products/:id
  def update
    @product.update(product_params)
    head :no_content
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  def assign_promotion
    json_response(@product) if @product.assign(params[:promotion_id])
  end

  private

  def product_params
    # whitelist params
    params.permit(:name, :price)
  end

  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_product
    @product = @department.products.find(params[:id]) if @department
  end
end
