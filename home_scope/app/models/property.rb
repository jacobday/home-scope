class Property
    include Mongoid::Document

    field :name, type: String
    field :description, type: String
    field :price, type: Float

    field :address, type: String
    field :zipcode, type: String

    def self.search(zipcode)
        where(zipcode: zipcode)
    end
end