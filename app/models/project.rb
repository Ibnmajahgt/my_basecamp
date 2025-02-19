class Project < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    has_many_attached :attachments
    has_many :discussions, dependent: :destroy # Ensure discussions are linked to projects
  end
  