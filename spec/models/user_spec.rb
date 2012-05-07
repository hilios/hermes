require 'spec_helper'

describe User do
  describe "collection" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:role).of_type(String) }
    it { should have_field(:is_active).of_type(Boolean) }

    context "devise" do
      it { should have_field(:email).of_type(String) }
      it { should have_field(:encrypted_password).of_type(String) }
      # Recoverable
      it { should have_field(:reset_password_token).of_type(String) }
      it { should have_field(:reset_password_sent_at).of_type(Time) }
      # Trackable
      it { should have_field(:sign_in_count).of_type(Integer) }
      it { should have_field(:current_sign_in_at).of_type(Time) }
      it { should have_field(:last_sign_in_at).of_type(Time) }
      it { should have_field(:current_sign_in_ip).of_type(String) }
      it { should have_field(:last_sign_in_ip).of_type(String) }
      # Encryptable
      it { should have_field(:password_salt).of_type(String) }
      # Rememberable
      it { should have_field(:remember_created_at).of_type(Time) }
    end
  end

  describe "validations" do
    specify { FactoryGirl.build(:user).should be_valid }
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }

    it { should allow_value("foo.bar@host.com").for(:email) }
    it { should_not allow_value("foo.bar.com").for(:email) }
    it { should_not allow_value("foo@host").for(:email) }
    it { should_not allow_value("foo@.co").for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end
  
  describe "#is?" do
    it "return true if given role matches user role"
  end
end
