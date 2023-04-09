# pro-rated-subscriptions

This was a recent code challenge where the answer was to be written in a series of helper methods. I wanted to rewrite it in a more OOP centered way.

```
Billing
  returns $0.00
    when no active users
    when subscription is nil
  calculates the total amount
    for an active usesr and pro rated user
    for two acitve users
    for two active users and one inactive user
    
Billing::Availabilty
  when billing date is out of bounds
  billing the full month
  prorated due to deactivated during billing date
  prorated due to activated during billing date

Billing::Subscription
  calculates the daily rate

Billing::User
  Billiable Dates
    tallys all days in a month when valid
    returns 0 if billing month of user is deactivated
    pro rates
      when deactivated in billing month
      when activated in billing month

```
