class Response < ApplicationRecord
  belongs_to :lecture
  belongs_to :user
  belongs_to :question
  belongs_to :answer
end
