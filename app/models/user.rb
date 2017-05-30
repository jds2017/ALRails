class User < ApplicationRecord
  validates :user_type_id, :numericality => true
end
