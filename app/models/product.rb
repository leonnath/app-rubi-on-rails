class Product < ApplicationRecord
    has_many :movements
    validates :name, presence: true

    def quantity 
        movement.sum(:quantity)
    end
end
