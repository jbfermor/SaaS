require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is valid with a unique name" do
    role = build(:role)
    expect(role).to be_valid
  end

  it "is invalid without a name" do
    role = build(:role, name: nil)
    expect(role).to_not be_valid
  end
end
