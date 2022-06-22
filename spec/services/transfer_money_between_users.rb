require 'rails_helper'

RSpec.describe Services::TransferMoneyBetweenUsers do
  subject { described_class.call(params) }

  describe '.call' do
    context 'when transfer is successfull' do
      before { user1.account.increment!(:balance, 100_00) }

      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:params) { { from: user1.login, to: user2.login, amount: 50_00} }

      it { is_expected.to be_truthy }

      it { expect { subject }.to change { user1.account.reload.balance }.from(100_00).to(50_00) }
      it { expect { subject }.to change { user2.account.reload.balance }.from(0).to(50_00) }
    end

    context 'when sender do not have enough money' do
      let(:user1)  { create(:user) }
      let(:user2)  { create(:user) }
      let(:params) { { from: user1.login, to: user2.login, amount: 50_00} }

      it { expect { subject }.to raise_error(ActiveRecord::StatementInvalid) }
    end

    context 'when params are invalid' do
      context 'and user login is invalid' do
        let(:params) { { from: false, to: true, amount: 'asdfe'} }

        it { expect { subject }.to raise_error(Dry::Types::CoercionError) }
      end

      context 'and amount is invalid' do
        let(:params)  { { from: 'qwer', to: 'asdf', amount: 'asdfe'} }

        it { expect { subject }.to raise_error(Dry::Types::CoercionError) }
      end

      context 'and values are empty' do
        let(:params)  { { login: 'asdf' } }

        it { expect { subject }.to raise_error(Dry::Types::CoercionError) }
      end
    end

    context 'when user does not exist' do
      let(:params) { { amount: 100_00 } }

      it { expect{ subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end