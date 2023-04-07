require 'date'
require 'billing/user'
require 'billing/availabilty'
require 'billing/subscription'

module Billing
  module_function

  def amount(month, subscription, users)
    return 0 if subscription.nil?

    subscription = Subscription.new(subscription)
    bill_date    = Date.strptime(month, '%Y-%m')
    users        = users.map { |user| User.new(user) }

    active_days(users, bill_date) * subscription.daily_amount(bill_date)
  end

  def active_days(users, bill_date)
    users.reduce(0) do |result, user|
      result + user.billable_days(bill_date)
    end
  end
end
