class Category < ApplicationRecord
  has_many :services, dependent: :destroy
end
