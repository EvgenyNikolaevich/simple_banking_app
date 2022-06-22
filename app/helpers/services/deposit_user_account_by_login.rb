module Services
  class DepositUserAccountByLogin
    def self.call(params)
      new.call(**params)
    end

    def call(params, logger = LoggerWrapper)
      valid_params = validate_params(params)
      account      = User.find_by!(login: valid_params[:login]).account

      deposit_account(account, valid_params[:amount])
      logger.call(:debug, params, self.class)
    end

    private

    def validate_params(params)
      login  = Dry.Types::Coercible::String[params[:login]]
      amount = Dry.Types::Coercible::Integer[params[:amount]]

      { login: login, amount: amount }
    end

    def deposit_account(account, amount)
      account.with_lock { account.increment!(:balance, amount) }
    end
  end
end