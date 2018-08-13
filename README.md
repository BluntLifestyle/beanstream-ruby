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
Take a credit card Payment:
```ruby
include Bambora::API

response = Payment.create({
  order_number: '20X8-R123...',
  amount: 12.95,
  payment_method: :card,
  card: {
    name: 'John Smith',
    number: '4030000010001234',
    expiry_year: '07',
    expiry_year: '22',
    cvd: '123'
  }
})
```

# Reporting Issues
Found a bug or want a feature improvement? Create a new Issue here on the github page, or email Bambora support support@beanstream.com
