class User < ApplicationRecord
  after_create :create_account

  # has_secure_password
  has_one :account, dependent: :destroy

  def create_account
    # move to: Services::CreateAccount.call(self.id)
    Account.create!(user_id: self.id)
  end
end
