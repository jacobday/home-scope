class Admin::PropertiesController < ApplicationController
    def index
      @properties = Property.all
    end

    def show
      redirect_to admin_properties_path
    end
  
    def new
      @property = Property.new
    end
  
    def create
      @property = Property.new(property_params)
    
      if @property.save
        redirect_to admin_properties_path
      else
        render 'new'
      end
    end
    
    def edit
      @property = Property.find(params[:id])

      if @property.edit(property_params)
        redirect_to admin_properties_path, notice: 'Property was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @property = Property.find(params[:id])
      if @property.destroy
        redirect_to admin_properties_path, notice: "Property deleted successfully."
      else
        redirect_to admin_properties_path, alert: "Failed to delete property."
      end
    end
  
    private
  
    def property_params
      if URI::regexp(%w(http https)).match?(params[:property][:image])
        params.require(:property).permit(:status, :price, :address1, :address2, :image)
      else
        flash[:error] = "Invalid image URL"
        redirect_to new_admin_property_path and return
      end
    end
    
  end
  