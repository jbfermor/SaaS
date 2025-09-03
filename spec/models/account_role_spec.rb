require "rails_helper"

RSpec.describe AccountRole, type: :model do
  let(:insider_role) { Role.create!(name: "insider") }
  let(:insider) { User.create!(email: "insider@test.com", password: "123456", role: insider_role) }
  let(:another_insider) { User.create!(email: "another@test.com", password: "123456", role: insider_role) }
  let(:account) { Account.create!(name: "Cuenta Test", creator: insider) }

  describe "validations" do
    it "is valid with account, user and name" do
      test_account = create(:account, creator: insider)
      role = test_account.account_roles.first
      expect(role).to be_valid
    end

    it "is invalid without account" do
      role = AccountRole.new(user: insider, name: "super")
      expect(role).not_to be_valid
    end

    it "is invalid without user" do
      role = AccountRole.new(account: account, name: "super")
      expect(role).not_to be_valid
    end

    it "is invalid without name" do
      role = AccountRole.new(account: account, user: insider)
      expect(role).not_to be_valid
    end

    it "is invalid with a name outside allowed values" do
      role = AccountRole.new(account: account, user: insider, name: "manager")
      expect(role).not_to be_valid
    end
  end

  describe "business rules" do
    it "allows only one super per account" do
      test_account = Account.create!(name: "Otra Cuenta", creator: another_insider)
      expect {
        AccountRole.create!(account: test_account, user: another_insider, name: "super")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "does not allow the same user to have two roles in the same account" do
      test_account = Account.create!(name: "Otra Cuenta", creator: another_insider)
      expect {
        AccountRole.create!(account: test_account, user: another_insider, name: "worker")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "allows a user to have roles in different accounts" do
      test_account = Account.create!(name: "Otra Cuenta", creator: insider)
      another_account = Account.create!(name: "Cuenta Adicional", creator: insider)
      role1 = test_account.account_roles.first
      role2 = another_account.account_roles.first

      expect(role1).to be_valid
      expect(role2).to be_valid
    end
  end
end
