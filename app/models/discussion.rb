class Discussion < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :messages, dependent: :destroy
end
