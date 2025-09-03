class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  has_many :created_accounts, class_name: "Account", foreign_key: "creator_id"
  has_many :account_roles
  has_many :accounts, through: :account_roles

  before_validation :assign_default_role

  private

  def assign_default_role
    self.role ||= Role.find_by(name: "visitor")
  end
end
