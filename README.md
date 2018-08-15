# Bambora's Ruby SDK

Integration with Bambora’s payments gateway is a simple, flexible solution.

You can choose between a straightforward payment requiring very few parameters; or, you can customize a feature-rich integration.

To assist as a centralized record of all your sales, we also accept cash and cheque transactions.

For very detailed information on the Payments API, look at the Bambora developer portal's [documentation](http://developer.beanstream.com/documentation/take-payments/purchases-pre-authorizations/).

# Setup
To install the SDK you just need to simply install the gem file:
```
gem install bambora
```

# Code Sample
Process a credit card payment
```ruby
include Bambora::API

payment = Payment.create(
  amount: 12.95,
  card: {
    name: 'John Smith',
    number: '4030000010001234',
    expiry_year: '07',
    expiry_year: '22',
    cvd: '123'
  }
)
```

Create a token to process a payment or create a profile
```ruby
token = Token.create(
  number: '4030000010001234',
  expiry_year: '07',
  expiry_year: '22',
  cvd: '123'
)
```

Search for transactions matching 10.00 $
```ruby
records = Report.search(criteria: [{ field: 'amount', operator: 'equals', value: 10.0 }] )
```

Create a payment profile for a credit card
```ruby
profile = Profile.create card: {
  name: 'John Smith',
  number: '4030000010001234',
  expiry_year: '07',
  expiry_year: '22',
  cvd: '123'
}
```

Or use a token
```ruby
profile = Profile.create token: {
  name: 'John Smith',
  code: 'a02-1e644205-9cef-4fb4-b00c-41ab7627333c'
}
```

# Reporting Issues

Found a bug or want a feature improvement? Create a new Issue here on the github page, or email Bambora support support@beanstream.com
