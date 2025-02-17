class Project < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    has_many_attached :attachments
    
end
