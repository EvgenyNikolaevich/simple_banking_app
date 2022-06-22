module Services
  class TransferMoneyBetweenUsers
    def self.call(params)
      new.call(**params)
    end

    def call(params)
      valid_params = validate_params(params)
      sender       = User.find_by!(login: valid_params[:sender_login]).account
      recipient    = User.find_by!(login: valid_params[:recipient_login]).account

      transfer_money(sender, recipient, valid_params[:amount])
      log_transfer(valid_params)
    end

    private

    def validate_params(params)
      from    = Dry.Types::Coercible::String[params[:from]]
      to      = Dry.Types::Coercible::String[params[:to]]
      amount  = Dry.Types::Coercible::Integer[params[:amount]]

      { 
        sender_login: from,
        recipient_login: to,
        amount: amount
      }
    end

    def transfer_money(sender, recipient, amount)
      ActiveRecord::Base.transaction do
        sender.decrement!(:balance, amount)
        recipient.increment!(:balance, amount)
      end
    end

    def log_transfer(params)
      LoggerWrapper.call(:debug, params, self.class)
    end
  end
end