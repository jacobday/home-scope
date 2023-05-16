class Admin::PropertiesController < ApplicationController
    def index
      # Fetch all of the properties
      @properties = Property.all
    end

    def show
      # Redirect to the admin index page
      redirect_to admin_properties_path
    end

    def new
      # Initialize a new property object
      @property = Property.new
    end

    def create
      # Create a new property object with the submitted parameters
      @property = Property.new(property_params)

      if @property.save
        # If the property is successfully saved, redirect to the admin index page
        redirect_to admin_properties_path
      else
        # Otherwise, if there are validation errors, show the new property form
        render 'new'
      end
    end

    def edit
      # Find the property to be edited based on the submitted ID
      @property = Property.find(params[:id])

      if @property.edit(property_params)
        # If the property is successfully edited, redirect to the admin index page
        redirect_to admin_properties_path, notice: 'Property was successfully updated.'
      else
        # Otherwise, if there are validation errors, show the edit property form
        render :edit
      end
    end

    def destroy
      # Find the property to be deleted based on the submitted ID
      @property = Property.find(params[:id])

      if @property.destroy
        # If the property is successfully deleted, redirect to the admin index page
        redirect_to admin_properties_path, notice: "Property deleted successfully."
      else
        # Otherwise, redirect and display an error message
        redirect_to admin_properties_path, alert: "Failed to delete property."
      end
    end

    private

    def property_params
      # Ensure the submitted parameters include a valid image URL
      if URI::regexp(%w(http https)).match?(params[:property][:image])
        params.require(:property).permit(:status, :price, :address1, :address2, :image)
      else
        # Otherwise, if the image URL is invalid, redirect to the new property form and display an error message
        flash[:error] = "Invalid image URL"
        redirect_to new_admin_property_path and return
      end
    end
  end
