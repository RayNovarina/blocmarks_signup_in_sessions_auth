require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
  # user factory method to create user.
  let(:user) { create(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }
  it { should allow_value('BlocmarksUser').for(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value('user@blocmarks.com').for(:email) }
  it { should_not allow_value('userblocmarks.com').for(:email) }

  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'attributes' do
    it 'should respond to name' do
      expect(user).to respond_to(:name)
    end

    it 'should respond to email' do
      expect(user).to respond_to(:email)
    end

    it 'should respond to role' do
      expect(user).to respond_to(:role)
    end

    it 'should respond to admin?' do
      expect(user).to respond_to(:admin?)
    end

    it 'should respond to member?' do
      expect(user).to respond_to(:member?)
    end
  end

  describe 'roles' do
    # User.create! defaults .role to :member
    it 'should be member by default' do
      expect(user.role).to eql('member')
    end

    context 'member user' do
      it 'should return true for #member?' do
        expect(user.member?).to be_truthy
      end

      it 'should return false for #admin?' do
        expect(user.admin?).to be_falsey
      end
    end

    context 'admin user' do
      before do
        # Set user.role to :admin
        user.admin!
      end

      it 'should return false for #member?' do
        expect(user.member?).to be_falsey
      end

      it 'should return true for #admin?' do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe 'invalid user' do
    let(:user_with_invalid_name) { build(:user, name: '') }
    let(:user_with_invalid_email) { build(:user, email: '') }
    let(:user_with_invalid_email_format
       ) { build(:user, email: 'invalid_format') }

    it 'should be an invalid user due to blank name' do
      expect(user_with_invalid_name).to_not be_valid
    end

    it 'should be an invalid user due to blank email' do
      expect(user_with_invalid_email).to_not be_valid
    end

    it 'should be an invalid user due to incorrectly formatted email address' do
      expect(user_with_invalid_email_format).to_not be_valid
    end
  end

  describe '.avatar_url' do
    let(:known_user) { create(:user, email: 'blochead@bloc.io') }

    it 'returns the proper Gravatar url for a known email entity' do
      expected_gravatar = 'http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48'
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end

  describe '#generate_auth_token' do
    it 'creates a token' do
      expect(user.auth_token).to_not be_nil
    end
  end
end
