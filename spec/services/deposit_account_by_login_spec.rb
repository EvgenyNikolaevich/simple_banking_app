require 'rails_helper'

RSpec.describe Services::DepositUserAccountByLogin do
  subject { described_class.call(params) }

  describe '.call' do
    context 'when deposit is successfull' do
      let!(:user)   { User.create(login: 'qwer', password: 'asdfs') }
      let(:params) { { login: 'qwer', amount: 100_00} }

      it { is_expected.to be_truthy }
      it { expect { subject }.to change { user.account.reload.balance }.from(0).to(100_00) }
    end

    context 'when params are invalid' do
      context 'and user login is invalid' do
        let(:params)  { { login: false, amount: 'asdfe'} }

        it { expect { subject }.to raise_error(Dry::Types::CoercionError) }
      end

      context 'and amount is invalid' do
        let(:params)  { { login: 'qwer', amount: 'asdfe'} }

        it { expect { subject }.to raise_error(Dry::Types::CoercionError) }
      end

      context 'and values are empty' do
        let(:params)  { { login: 'asdf' } }

        it { expect { subject }.to raise_error(Dry::Types::CoercionError) }
      end
    end

    context 'when user does not exist' do
      let(:params) { { login: 'qwer', amount: 100_00} }

      it { expect{ subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end