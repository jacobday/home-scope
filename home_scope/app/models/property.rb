class Property
    include Mongoid::Document

    field :status, type: String
    field :price, type: String
    field :address1, type: String
    field :address2, type: String
    field :image, type: String

    def self.search(query)
        # Prevent regex injection by sanitizing the user's input
        escaped_query = Regexp.escape(query)

        regex = /#{escaped_query}/i
        Property.or({ address1: regex }, { address2: regex })
    end
end
