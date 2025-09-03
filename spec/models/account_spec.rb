require "rails_helper"

RSpec.describe Account, type: :model do
  let(:insider_role) { Role.create!(name: "insider") }
  let(:visitor_role) { Role.create!(name: "visitor") }
  let(:insider) { User.create!(email: "insider@test.com", password: "123456", role: insider_role) }
  let(:visitor) { User.create!(email: "visitor@test.com", password: "123456", role: visitor_role) }

  describe "validations" do
    it "is valid with name and creator" do
      account = Account.new(name: "Cuenta 1", creator: insider)
      expect(account).to be_valid
    end

    it "is invalid without a name" do
      account = Account.new(creator: insider)
      expect(account).not_to be_valid
    end

    it "is invalid without a creator" do
      account = Account.new(name: "Cuenta sin creador")
      expect(account).not_to be_valid
    end
  end

  describe "callbacks" do
    it "assigns creator as super when account is created" do
      account = Account.create!(name: "Cuenta Test", creator: insider)
      role = account.account_roles.find_by(user: insider)
      expect(role.name).to eq("super")
    end
  end

  describe "uniqueness of super" do
    it "does not allow two supers in the same account" do
      account = Account.create!(name: "Cuenta Única", creator: insider)

      another_user = User.create!(email: "another@test.com", password: "123456", role: Role.find_by(name: "insider"))

      expect {
        AccountRole.create!(account: account, user: another_user, name: "super")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
