class PropertiesController < ApplicationController
    def index
        @properties = if params[:search].present?
                            Property.search(params[:search])
        else
            Property.all
        end
    end
end
