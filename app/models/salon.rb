class Salon < ApplicationRecord
  belongs_to :user
  has_many :salon_services, dependent: :destroy
  has_many :services, through: :salon_services, class_name: 'Service'

  accepts_nested_attributes_for :salon_services

  mount_uploaders :images, ImageUploader
  serialize :images, JSON
end
