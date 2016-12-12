require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build :user }
  subject { FactoryGirl.build :user }

  describe "test respond" do
    it { expect(user).to respond_to(:email) }
    it { expect(user).to respond_to(:password) }
    it { expect(user).to respond_to(:password_confirmation) }

    it { expect(user).to be_valid }
  end

  describe  "Test email"  do
     it "success with email valid" do
       expect(user).to be_valid(:email)
     end

     it "email should not be too long" do
       subject.email = "a" * 254 + "@pdk.com"
       is_expected.to  have_at_least(1).errors_on(:email)
     end

     it "email validation should acept valid address" do
       valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
         user.email = valid_address
         expect(user).to  be_valid(:email)
       end
     end

     it "email validation should reject invalid addresses" do
       invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
         subject.email = invalid_address
         is_expected.to have_at_least(1)
           .errors_on( :email,
                        context: "{invalid_address.inspect} should be invalid")
       end
     end

     it "email validate uniquess" do
       subject.email = user.email
       user.save
       is_expected.to have_at_least(1).error_on(:email)
     end

     it "email address should be saved as lower-case" do
       subject.email = user.email.upcase
       user.email.downcase
       user.save
       is_expected.to have_at_least(1).errors_on(:email)
     end
   end

   describe  "test password" do
    it "password should be present (not blak)" do
      subject.password = subject.password_confirmation = " " * 6
      is_expected.to  have_at_least(1).error_on(:password)
    end

    it "password should have a minimum length" do
      subject.password = subject.password_confirmation = "a" * 5
      is_expected.to  have_at_least(1).errors_on(:password)
    end
  end

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      user.generate_authentication_token!
      expect(user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      user.generate_authentication_token!
      expect(user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
