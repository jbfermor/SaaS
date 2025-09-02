# spec/models/user_spec.rb
require "rails_helper"

RSpec.describe User, type: :model do
  let!(:visitor_role)   { Role.create!(name: "visitor") }
  let!(:insider_role)   { Role.create!(name: "insider") }

  describe "validations" do
    it "is valid with basic attributes" do
      user = User.new(email: "test@example.com", password: "password", role: visitor_role)
      expect(user).to be_valid
    end
  end

  describe "default role" do
    it "assigns visitor role if no role is provided" do
      user = User.create!(email: "visitor@example.com", password: "password")
      expect(user.role.name).to eq("visitor")
    end

    it "keeps the role if explicitly set" do
      user = User.create!(email: "insider@example.com", password: "password", role: insider_role)
      expect(user.role.name).to eq("insider")
    end
  end

end
