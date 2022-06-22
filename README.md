Install app:

```
bundle
rails db:create
rails db:migrate
```

Create new user:
```
rails c
login1 = User.create!(login: 'John', password: 'qwerty')
login2 = User.create!(login: 'John', password: 'qwerty')
```

Deposit user's bank account:
```
Services::DepositUserAccountByLogin.call(login: login1, amount: 100_00)
```

Transfer money:
```
Services::TransferMoneyBetweenUsers.call(from: login1, to: login2, amount: 50_00)
```