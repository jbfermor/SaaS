class Account < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :account_roles, dependent: :destroy
  has_many :users, through: :account_roles

  validates :name, presence: true

  after_create :assign_super_to_creator

  private

  def assign_super_to_creator
    account_roles.create!(user: self.creator, name: "super")
    insider_role = Role.find_by(name: "insider")
    if self.creator.role.name == "visitor" && insider_role
      self.creator.update!(role: insider_role)
    end
  end
end
