class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]

  # GET /departments
  def index
    @departments = Department.all
    json_response(@departments)
  end

  # POST /departments
  def create
    @department = Department.create!(department_params)
    json_response(@department, :created)
  end

  # GET /departments/:id
  def show
    json_response(@department)
  end

  # PUT /departments/:id
  def update
    @department.update(department_params)
    head :no_content
  end

  # DELETE /departments/:id
  def destroy
    @department.destroy
    head :no_content
  end

  private

  def department_params
    # whitelist params
    params.permit(:name)
  end

  def set_department
    @department = Department.find(params[:id])
  end
end
