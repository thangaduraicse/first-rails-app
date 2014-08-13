require 'spec_helper'

describe "User" do
  before { @user = User.new(name: "Test", email: "Tester@contractiq.com", password: "test123!", password_confirmation: "test123!")}
  
  subject {@user}

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}
  it { should respond_to(:remember_token)}

  it { should be_valid }

  describe "When name is not present" do
  	before { @user.name="" }
  	it { should_not be_valid }
  end

 describe "When email is not present" do
 	before { @user.email=""}
 	it { should_not be_valid }
 end

 describe "When name is too long" do
 	before { @user.name = "a"*51 }
 	it { should_not be_valid }
 end

 describe "When email format is invalid" do
 	it "should be invalid" do
 		addresses = %w[user@foo,com user_at_foo.org example@123*com ]
 		addresses.each do |invalid_addresses|
 			@user.email=invalid_addresses
 			expect(@user).not_to be_valid
 		end
 	end
 end	

 describe "When email format is valid" do
 	it "should be valid" do
 		addresses = %w[user@foo.com user_at@foo.org example@123.com ]
 		addresses.each do |valid_addresses|
 			@user.email=valid_addresses
 			 expect(@user).to be_valid
 		end
 	end
 end

 describe "when email address is already taken" do
 	before do
 		user_with_same_email = @user.dup
 		user_with_same_email.email = @user.email.upcase
 		user_with_same_email.save
 	end
 	it { should_not be_valid }
 end

 describe "email address with mixed case" do
    let(:mixed_case_email) { "ThangadDurai@GmaiL.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
 describe "when password is not present" do
  before {@user = User.new(name: "Test", email: "tester@contractiq.com", password: " ", password_confirmation: " ")}
  it { should_not be_valid}
 end

 describe "when password doesn't match confirmation" do
  before {@user.password_confirmation = "mismatch"}
  it { should_not be_valid}
 end
 
 describe "return value of authenticate method" do
  before {@user.save}
  let(:found_user) { User.find_by(email: @user.email)}
  describe "with valid password" do
    it { should eq found_user.authenticate(@user.password)}
  end
  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid")}
    it { should_not eq user_for_invalid_password}
    specify { expect(user_for_invalid_password).to be_false}
  end
 end 

 describe "with a password that's too short" do
  before { @user.password = @user.password_confirmation = "a"*5}
  it { should_not be_valid}
 end

 describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
 end

end
