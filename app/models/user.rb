class User < ApplicationRecord
  include BCrypt

  after_create :create_account

  has_one :account, dependent: :destroy

  def create_account
    # move to: Services::CreateAccount.call(self.id)
    Account.create!(user_id: self.id)
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
