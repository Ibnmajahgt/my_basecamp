class User < ApplicationRecord
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :projects
  has_and_belongs_to_many :roles, join_table: :users_roles

end
