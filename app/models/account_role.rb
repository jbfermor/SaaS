class AccountRole < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :name, inclusion: { in: %w[super worker] }
  validates :name, uniqueness: { scope: :account_id, message: "solo puede haber un super por cuenta" }, if: -> { name == "super" }
  validates :user_id, uniqueness: { scope: :account_id, message: "solo puede tener un rol por cuenta" }


end
