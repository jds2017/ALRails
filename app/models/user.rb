class User < ApplicationRecord
  has_many :registrations
  has_many :courses, through: :registrations
end
