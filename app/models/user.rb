class User < ApplicationRecord
	has_many :salons, dependent: :destroy
end
