class CustomersController < ApplicationController
  before_action :set_customer, only: [ :edit, :update, :destroy ]
  def index
        @customers = Customer.all
  end

  def new
        @customer = Customer.new
        @customer.build_address
  end

  def create
        @customer = Customer.new(customer_params)

        if @customer.save
            redirect_to customers_path
        else
            render :new
        end
  end

  def edit
    @customer.build_address unless @customer.address
  end

  def update
    if @customer.update(customer_params)
        redirect_to customers_path, notice: "Cliente atualizado com sucesso."
    else
        render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "Cliente deletado com sucesso."
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
        params.require(:customer).permit(:name, :phone, address_attributes: [ :id, :street, :city, :number ])
  end
end
