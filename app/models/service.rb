class Service < ApplicationRecord
  belongs_to :category
  has_many :salon_services, dependent: :destroy
  has_many :salons, through: :salon_services, class_name: 'Salon'
end
