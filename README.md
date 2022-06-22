Install app:

Prepare -> install psql, create db user and etc.

```
bundle
rails db:create
rails db:migrate
```

Create new user:
```
rails c
User.create!(login: 'John', password: 'qwerty')
```

Deposit user's bank account:
```
rails c
CALL SERVICE
```