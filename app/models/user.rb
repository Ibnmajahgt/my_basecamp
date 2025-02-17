class User < ApplicationRecord
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :projects
  has_and_belongs_to_many :roles, join_table: :users_roles

  # Define admin? method
  def admin?
    has_role?(:admin)  # Returns true if the user has the admin role
  end
end
