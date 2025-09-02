class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  has_many :account_roles, dependent: :destroy
  has_many :accounts, through: :account_roles

  before_validation :assign_default_role

  private

  def assign_default_role
    self.update(role: Role.find_by(name: "visitor")) if role.nil?
  end
end
